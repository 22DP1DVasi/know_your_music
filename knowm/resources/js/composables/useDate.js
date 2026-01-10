/*
daļa no composables - bieži atkārtoti izmantojamā loģika
definē un atgriež dažas metodes darbam ar laiku
 */

import { useI18n } from 'vue-i18n'
import dayjs from '@/utils/dayjs'

export function useDate() {
    const { locale } = useI18n()

    const formatDateLL = (date, format = 'LL') => {
        locale.value
        return dayjs(date).format(format)
    }

    const fromNow = (date) => {
        locale.value
        return dayjs(date).fromNow()
    }

    return {
        formatDateLL,
        fromNow
    }
}
