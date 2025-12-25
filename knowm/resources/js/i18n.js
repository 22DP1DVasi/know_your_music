import { createI18n } from 'vue-i18n'
import enNavbar from './i18n/en/navbar.json'
import lvNavbar from './i18n/lv/navbar.json'

const savedLocale = localStorage.getItem('locale') || 'lv'

const i18n = createI18n({
    legacy: false,
    locale: savedLocale,
    fallbackLocale: 'en',
    messages: {
        en: {
            navbar: enNavbar
        },
        lv: {
            navbar: lvNavbar
        }
    }
})

export default i18n
