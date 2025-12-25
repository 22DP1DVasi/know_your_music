import { createI18n } from 'vue-i18n'
import enNavbar from './i18n/en/navbar.json'
import enHome from './i18n/en/home.json'

import lvNavbar from './i18n/lv/navbar.json'
import lvHome from './i18n/lv/home.json'

const savedLocale = localStorage.getItem('locale') || 'lv'

const i18n = createI18n({
    legacy: false,
    locale: savedLocale,
    fallbackLocale: 'en',
    messages: {
        en: {
            navbar: enNavbar,
            home: enHome
        },
        lv: {
            navbar: lvNavbar,
            home: lvHome
        }
    }
})

export default i18n
