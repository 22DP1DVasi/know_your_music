# ============================================
# Stage 1: Build assets (Node + Composer)
# ============================================
FROM php:8.2-cli AS builder

# Install system packages needed for build
RUN apt-get update && apt-get install -y \
    curl \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions used by Laravel
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql bcmath

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Node 18 (for Vue / Vite build)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

# Copy dependency manifests first (better cache usage)
COPY composer.json composer.lock package.json package-lock.json ./
RUN composer install --no-dev --no-scripts --prefer-dist --no-interaction --optimize-autoloader
RUN npm ci

# Copy the rest of the source code
COPY . .

# Build frontend (Vite / Vue)
RUN npm run build

# Remove node_modules to keep final image small (optional)
RUN rm -rf node_modules

# Run any necessary artisan commands that can be done at build time
RUN php artisan event:cache \
    && php artisan route:cache \
    && php artisan config:cache \
    && php artisan view:cache

# ============================================
# Stage 2: Production runtime image
# ============================================
FROM php:8.2-fpm

# Install runtime + temporary build dependencies for GD
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-fcgid \
    libpng16-16 \
    libjpeg62-turbo \
    libfreetype6 \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Compile GD and other PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo pdo_mysql bcmath

# Remove dev packages
RUN apt-get purge -y libpng-dev libjpeg-dev libfreetype6-dev zlib1g-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www
COPY --from=builder /var/www /var/www

RUN chown -R www-data:www-data storage bootstrap/cache \
    && chmod -R 775 storage bootstrap/cache

# --- Apache: clear all default sites, use our config ---
RUN rm -rf /etc/apache2/sites-enabled/* /etc/apache2/sites-available/*
COPY apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default && \
    a2enmod actions fcgid alias proxy_fcgi

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 80
CMD ["/start.sh"]
