<script setup>
import {Link, router, usePage} from '@inertiajs/vue3'
import { ref, watchEffect } from 'vue'
import { useI18n } from 'vue-i18n'
import {route} from "ziggy-js";
import axios from 'axios';

const page = usePage();
const mobileMenuOpen = ref(false);
const showFlash = ref(true);

const { locale, t } = useI18n();

const toggleMobileMenu = () => {
    mobileMenuOpen.value = !mobileMenuOpen.value;
}

const changeLanguage = async (lang) => {
    locale.value = lang;
    localStorage.setItem('locale', lang);
    await axios.post('/locale', { locale: lang });
    router.reload({
        preserveScroll: true,
        preserveState: true,
    });
};

watchEffect(() => {
    if (page.props.flash?.success || page.props.flash?.error) {
        showFlash.value = true;
        setTimeout(() => showFlash.value = false, 5000);
    }
})

</script>

<template>
    <div class="admin-layout">
        <button class="mobile-menu-btn" @click="toggleMobileMenu" v-if="!mobileMenuOpen">
            ☰
        </button>

        <aside class="sidebar" :class="{ 'mobile-open': mobileMenuOpen }">
            <div class="admin-language-switch">
                <button
                    :class="{ active: locale === 'en' }"
                    @click="changeLanguage('en')"
                >
                    EN
                </button>
                <button
                    :class="{ active: locale === 'lv' }"
                    @click="changeLanguage('lv')"
                >
                    LV
                </button>
            </div>

            <nav>
                <ul>
                    <li><Link :href="route('admin-dashboard')">{{ t('adm_layout.dashboard') }}</Link></li>
                    <li><Link :href="route('admin-users-index')">{{ t('adm_layout.users') }}</Link></li>
                    <li><Link :href="route('admin-roles-index')">{{ t('adm_layout.roles') }}</Link></li>
                    <li><Link :href="route('admin-artists-index')">{{ t('adm_layout.artists') }}</Link></li>
                </ul>
            </nav>
        </aside>

        <div
            v-if="mobileMenuOpen"
            class="mobile-overlay"
            @click="toggleMobileMenu"
        ></div>

        <main class="content">
            <!-- Flash ziņojumi -->
            <div v-if="showFlash && page.props.flash?.success" class="alert alert-success">
                {{ page.props.flash.success }}
            </div>
            <div v-if="showFlash && page.props.flash?.error" class="alert alert-error">
                {{ page.props.flash.error }}
            </div>

            <slot />
        </main>
    </div>
</template>

<style scoped>
.admin-layout {
    display: flex;
    min-height: 100vh;
    position: relative;
}

.sidebar {
    width: 150px;
    background: #2c3e50;
    color: white;
    padding: 1rem;
    transition: transform 0.3s ease;
    z-index: 1000;
}

.admin-language-switch {
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    margin-bottom: 1.5rem;
}

.admin-language-switch button {
    background: transparent;
    border: 1px solid #64748b;
    color: #e5e7eb;
    padding: 0.25rem 0.5rem;
    font-size: 0.75rem;
    border-radius: 0.25rem;
    cursor: pointer;
    transition: all 0.2s ease;
}

.admin-language-switch button:hover {
    background: #334155;
}

.admin-language-switch button.active {
    background: #10b981;
    border-color: #10b981;
    color: #022c22;
}

.content {
    flex: 1;
    padding: 2rem;
}

.alert {
    padding: 0.75rem 1rem;
    border-radius: 0.375rem;
    margin-bottom: 1rem;
    font-size: 0.875rem;
    transition: opacity 0.3s ease;
}

.alert-success {
    background-color: #ecfdf5;
    color: #065f46;
    border: 1px solid #10b981;
}

.alert-error {
    background-color: #fef2f2;
    color: #991b1b;
    border: 1px solid #ef4444;
}

.mobile-menu-btn {
    display: none;
    position: fixed;
    top: 1rem;
    left: 1rem;
    z-index: 1001;
    background: #2c3e50;
    color: white;
    border: none;
    padding: 0.5rem;
    border-radius: 0.25rem;
    cursor: pointer;
    font-size: 1.25rem;
}

.mobile-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    z-index: 999;
    opacity: 1;
}

.mobile-overlay.active {
    opacity: 1;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .mobile-menu-btn {
        display: block;
    }

    .mobile-overlay {
        display: block;
    }

    .sidebar {
        position: fixed;
        left: 0;
        top: 0;
        bottom: 0;
        z-index: 1000;
        transform: translateX(-100%);
    }

    .sidebar.mobile-open {
        transform: translateX(0);
    }

    .content {
        padding: 1rem;
        padding-top: 4rem;
    }

    .alert {
        font-size: 0.8rem;
        padding: 0.5rem 0.75rem;
    }
}

@media (max-width: 480px) {
    .sidebar {
        width: 200px;
    }

    .content {
        padding: 0.5rem;
        padding-top: 3.5rem;
    }
}

</style>
