import { createI18n } from 'vue-i18n'
import enNavbar from './i18n/en/navbar.json'
import enHome from './i18n/en/home.json'
import enAdmDashboard from './i18n/en/adm_dashboard.json'
import enAdmLayout from './i18n/en/adm_layout.json'
import enAdmUsers from './i18n/en/adm_users.json'
import enAdmRoles from './i18n/en/adm_roles.json'
import enAdmArtists from './i18n/en/adm_artists.json'

import lvNavbar from './i18n/lv/navbar.json'
import lvHome from './i18n/lv/home.json'
import lvAdmDashboard from './i18n/lv/adm_dashboard.json'
import lvAdmLayout from './i18n/lv/adm_layout.json'
import lvAdmAUsers from './i18n/lv/adm_users.json'
import lvAdmRoles from './i18n/lv/adm_roles.json'
import lvAdmArtists from './i18n/lv/adm_artists.json'

const savedLocale = localStorage.getItem('locale') || 'lv'

const i18n = createI18n({
    legacy: false,
    locale: savedLocale,
    fallbackLocale: 'en',
    messages: {
        en: {
            navbar: enNavbar,
            home: enHome,

            adm_dashboard: enAdmDashboard,
            adm_layout: enAdmLayout,
            adm_users: enAdmUsers,
            adm_roles: enAdmRoles,
            adm_artists: enAdmArtists
        },
        lv: {
            navbar: lvNavbar,
            home: lvHome,

            adm_dashboard: lvAdmDashboard,
            adm_layout: lvAdmLayout,
            adm_users: lvAdmAUsers,
            adm_roles: lvAdmRoles,
            adm_artists: lvAdmArtists
        }
    }
})

export default i18n
