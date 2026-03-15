/*
daļa no composables - bieži atkārtoti izmantojamā loģika
definē un atgriež dažas metodes darbam ar datumiem un laiku
UTC = saskaņotais pasaules laiks
 */

import { useI18n } from 'vue-i18n';
import dayjs from '@/utils/dayjs';
import utc from 'dayjs/plugin/utc';
import customParseFormat from 'dayjs/plugin/customParseFormat';

dayjs.extend(utc);
dayjs.extend(customParseFormat);

export function useDate() {
    const { locale } = useI18n();

    /**
     * Atgriež doto datumu LL formātā (MMM D, YYYY; piemēram: 2026. gada 22. februāris).
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
     * Atgriež doto datumu formātā DD.MM.YYYY (piemēram: 22.02.2026).
     *
     * @param date
     * @param format
     * @returns {string}
     */
    const formatDateDmyNumeric = (date, format = 'DD.MM.YYYY') => {
        locale.value;
        return dayjs(date).local().format(format);
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

    const formatDuration = (time, format = '') => {
        if (!time) return '';
        // parsēt kā UTC, lai izvairītos no laika joslas maiņām
        let parsed;
        if (format) {
            parsed = dayjs.utc(time, format);
        } else {
            parsed = dayjs.utc(time);
        }
        const hours = parsed.hour();
        const minutes = parsed.minute().toString().padStart(2, '0');
        const seconds = parsed.second().toString().padStart(2, '0');
        if (format === 'mm:ss' || hours === 0) {
            return `${minutes}:${seconds}`;
        }
        return `${hours.toString().padStart(2, '0')}:${minutes}:${seconds}`;
    };

    return {
        formatDateLL,
        formatDateDmyNumeric,
        fromNow,
        diffInMinutes,
        formatDuration
    };
}
