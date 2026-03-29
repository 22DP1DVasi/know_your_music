import { createI18n } from 'vue-i18n'
import dayjs from '@/utils/dayjs'
import { watch } from 'vue';

import enNavbar from './i18n/en/navbar.json'
import enFooter from './i18n/en/footer.json'
import enHome from './i18n/en/home.json'
import enInfoPages from './i18n/en/info_pages.json'
import enAdmDashboard from './i18n/en/adm_dashboard.json'
import enAdmLayout from './i18n/en/adm_layout.json'
import enAdmUsers from './i18n/en/adm_users.json'
import enAdmRoles from './i18n/en/adm_roles.json'
import enAdmArtists from './i18n/en/adm_artists.json'

import enUserPages from './i18n/en/user_pages.json'
import enArtists from './i18n/en/artists.json'

import enComponents from './i18n/en/components.json';

import lvNavbar from './i18n/lv/navbar.json'
import lvFooter from './i18n/lv/footer.json'
import lvHome from './i18n/lv/home.json'
import lvInfoPages from './i18n/lv/info_pages.json'
import lvAdmDashboard from './i18n/lv/adm_dashboard.json'
import lvAdmLayout from './i18n/lv/adm_layout.json'
import lvAdmAUsers from './i18n/lv/adm_users.json'
import lvAdmRoles from './i18n/lv/adm_roles.json'
import lvAdmArtists from './i18n/lv/adm_artists.json'

import lvUserPages from './i18n/lv/user_pages.json'
import lvArtists from './i18n/lv/artists.json'

import lvComponents from './i18n/lv/components.json';

const savedLocale = localStorage.getItem('locale') || 'lv'
dayjs.locale(savedLocale)

const i18n = createI18n({
    legacy: false,
    locale: savedLocale,
    fallbackLocale: 'en',
    messages: {
        en: {
            navbar: enNavbar,
            footer: enFooter,
            home: enHome,
            info_pages: enInfoPages,

            user_pages: enUserPages,

            artists: enArtists,

            adm_dashboard: enAdmDashboard,
            adm_layout: enAdmLayout,
            adm_users: enAdmUsers,
            adm_roles: enAdmRoles,
            adm_artists: enAdmArtists,

            components: enComponents
        },
        lv: {
            navbar: lvNavbar,
            footer: lvFooter,
            home: lvHome,
            info_pages: lvInfoPages,

            user_pages: lvUserPages,

            artists: lvArtists,

            adm_dashboard: lvAdmDashboard,
            adm_layout: lvAdmLayout,
            adm_users: lvAdmAUsers,
            adm_roles: lvAdmRoles,
            adm_artists: lvAdmArtists,

            components: lvComponents
        }
    }
})

// skatīties lokalizācijas izmaiņas un sinhronizēt dayjs
watch(
    () => i18n.global.locale.value,
    (newLocale) => {
        dayjs.locale(newLocale)
        localStorage.setItem('locale', newLocale)
    },
    { immediate: true }
)

export default i18n
