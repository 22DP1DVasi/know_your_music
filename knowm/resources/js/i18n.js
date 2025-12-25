import { createI18n } from 'vue-i18n'
import enNavbar from './i18n/en/navbar.json'
import enHome from './i18n/en/home.json'
import enAdmDashboard from './i18n/en/adm_dashboard.json'
import enAdmLayout from './i18n/en/adm_layout.json'

import lvNavbar from './i18n/lv/navbar.json'
import lvHome from './i18n/lv/home.json'
import lvAdmDashboard from './i18n/lv/adm_dashboard.json'
import lvAdmLayout from './i18n/lv/adm_layout.json'

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
            adm_layout: enAdmLayout
        },
        lv: {
            navbar: lvNavbar,
            home: lvHome,

            adm_dashboard: lvAdmDashboard,
            adm_layout: lvAdmLayout
        }
    }
})

export default i18n
