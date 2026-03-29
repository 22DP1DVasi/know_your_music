<script setup>
import { useI18n } from 'vue-i18n';

const { t } = useI18n();
const currentYear = new Date().getFullYear();

</script>

<template>
    <footer class="footer">
        <div class="footer-wave"></div>
        <div class="footer-container">
            <div class="footer-grid">
                <!-- Zīmola sadaļa -->
                <div class="footer-brand">
                    <div class="brand-logo">
                        <img src="/images/mini-logo.png" alt="Logo" class="logo">
                        <span>Know Your Music</span>
                    </div>
                    <p class="brand-description">
                        {{ t('footer.brand_description') }}
                    </p>
                    <div class="social-links">
                        <a href="#" class="social-link" aria-label="Facebook">
                            <i class="fa-brands fa-facebook-f"></i>
                        </a>
                        <a href="#" class="social-link" aria-label="Twitter">
                            <i class="fa-brands fa-twitter"></i>
                        </a>
                        <a href="#" class="social-link" aria-label="Instagram">
                            <i class="fa-brands fa-instagram"></i>
                        </a>
                        <a href="#" class="social-link" aria-label="Discord">
                            <i class="fa-brands fa-discord"></i>
                        </a>
                    </div>
                </div>

                <!-- Ātrās saites -->
                <div class="footer-section">
                    <h4 class="footer-heading">{{ t('footer.quick_links') }}</h4>
                    <ul class="footer-links">
                        <li><a href="/about">{{ t('footer.about_us') }}</a></li>
                        <li><a href="/contact">{{ t('footer.contact') }}</a></li>
                        <li><a href="/faq">{{ t('footer.faq') }}</a></li>
                    </ul>
                </div>

                <!-- Juridiskā informācija -->
                <div class="footer-section">
                    <h4 class="footer-heading">{{ t('footer.legal') }}</h4>
                    <ul class="footer-links">
                        <li><a href="/privacy-policy">{{ t('footer.privacy_policy') }}</a></li>
                        <li><a href="/terms-of-service">{{ t('footer.terms_of_service') }}</a></li>
                        <li><a href="/community-guidelines">{{ t('footer.community_guidelines') }}</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Autortiesības -->
        <div class="footer-bottom">
            <p>&copy; {{ currentYear }} {{ t('footer.copyright') }}</p>
        </div>
    </footer>
</template>

<style scoped>
.footer {
    position: relative;
    background: linear-gradient(135deg, #0c2a4a 0%, #0c4baa 100%);
    color: #ffffff;
    padding-top: 3rem;
    margin-top: 4rem;
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
}

.footer-wave {
    position: absolute;
    top: -60px;
    left: 0;
    width: 100%;
    height: 60px;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 320'%3E%3Cpath fill='%23ffffff' fill-opacity='1' d='M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,122.7C672,117,768,139,864,154.7C960,171,1056,181,1152,165.3C1248,149,1344,107,1392,85.3L1440,64L1440,0L1392,0C1344,0,1248,0,1152,0C1056,0,960,0,864,0C768,0,672,0,576,0C480,0,384,0,288,0C192,0,96,0,48,0L0,0Z'%3E%3C/path%3E%3C/svg%3E") repeat-x;
    background-size: cover;
    opacity: 0.1;
}

.footer-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
}

.footer-grid {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    gap: 2rem;
    margin-bottom: 2rem;
}

.footer-brand {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.brand-logo {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.logo {
    width: 50px;
    height: 50px;
    object-fit: contain;
    filter: brightness(0) invert(1);
}

.brand-logo span {
    font-size: 1.25rem;
    font-weight: 700;
    background: linear-gradient(135deg, #ffffff, #b3eaff);
    background-clip: text;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.brand-description {
    font-size: 0.9rem;
    line-height: 1.5;
    color: #cbd5e1;
    margin: 0;
}

.social-links {
    display: flex;
    gap: 1rem;
    margin-top: 0.5rem;
}

.social-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 36px;
    height: 36px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
    color: white;
    text-decoration: none;
    transition: all 0.3s ease;
}

.social-link:hover {
    background: #20c1f7;
    transform: translateY(-3px);
}

.social-link i {
    font-size: 1rem;
}

.footer-section {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.footer-heading {
    font-size: 1rem;
    font-weight: 600;
    margin: 0;
    position: relative;
    display: inline-block;
}

.footer-heading::after {
    content: '';
    position: absolute;
    bottom: -0.5rem;
    left: 0;
    width: 30px;
    height: 2px;
    background: #20c1f7;
    border-radius: 2px;
}

.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.footer-links li a {
    color: #cbd5e1;
    text-decoration: none;
    font-size: 0.9rem;
    transition: all 0.2s ease;
    display: inline-block;
}

.footer-links li a:hover {
    color: #20c1f7;
    transform: translateX(4px);
}

.footer-bottom {
    text-align: center;
    padding: 1.5rem 2rem;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    font-size: 0.85rem;
    color: #94a3b8;
}

.footer-bottom p {
    margin: 0;
}

/* Responsivitāte */
@media (max-width: 1024px) {
    .footer-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 2rem;
    }
}

@media (max-width: 768px) {
    .footer {
        padding-top: 2rem;
        margin-top: 2rem;
    }

    .footer-container {
        padding: 0 1.5rem;
    }

    .footer-grid {
        grid-template-columns: 1fr;
        gap: 2rem;
    }

    .footer-brand {
        text-align: center;
        align-items: center;
    }

    .brand-description {
        text-align: center;
    }

    .footer-section {
        align-items: center;
        text-align: center;
    }

    .footer-heading::after {
        left: 50%;
        transform: translateX(-50%);
    }

    .footer-bottom {
        padding: 1rem;
        font-size: 0.75rem;
    }
}

@media (max-width: 480px) {
    .footer-grid {
        gap: 1.5rem;
    }
}

/* Animācijas */
.footer-section {
    animation: fadeInUp 0.5s ease-out backwards;
}

.footer-section:nth-child(1) { animation-delay: 0.1s; }
.footer-section:nth-child(2) { animation-delay: 0.2s; }
.footer-section:nth-child(3) { animation-delay: 0.3s; }
.footer-section:nth-child(4) { animation-delay: 0.4s; }

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

</style>
