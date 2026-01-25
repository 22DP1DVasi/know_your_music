/*
daļa no composables - bieži atkārtoti izmantojamā loģika
definē un atgriež dažas metodes darbam ar datumiem un laiku
UTC = saskaņotais pasaules laiks
 */

import { useI18n } from 'vue-i18n'
import dayjs from '@/utils/dayjs'
import utc from 'dayjs/plugin/utc'

dayjs.extend(utc);

export function useDate() {
    const { locale } = useI18n();

    /**
     * Atgriež doto datumu LL formātā (MMM D, YYYY).
     *
     * @param date
     * @param format
     * @returns {*}
     */
    const formatDateLL = (date, format = 'LL') => {
        locale.value;
        return dayjs(date).format(format);
    };

    /**
     * Atgriež cilvēklasāmu laika aprakstu (piem., "pirms 5 minūtēm"),
     * aprēķinot laiku no norādītā datuma līdz pašreizējam brīdim,
     * pārveidojot UTC datumu uz lokālo laika joslu.
     *
     * @param date
     * @returns {string}
     */
    const fromNow = (date) => {
        locale.value;
        return dayjs.utc(date).local().fromNow();
    };

    /**
     * Atgriež atšķirību starp pašreizējo laiku un norādīto laikspiedolu minūtēs.
     * Aprēķins tiek veikts UTC formātā.
     *
     * @param date
     * @returns {number|number|number}
     */
    const diffInMinutes = (date) => {
        if (!date) return 0;
        const now = dayjs.utc();
        const target = dayjs.utc(date);
        if (!target.isValid()) return 0;
        const diff = now.diff(target, 'minute');
        return diff < 0 ? 0 : diff;
    };

    return {
        formatDateLL,
        fromNow,
        diffInMinutes,
    };
}
