/*
fails priekš dayjs bibliotēkai
paplašina ar spraudņiem un eksportē
 */

import dayjs from 'dayjs'
import relativeTime from 'dayjs/plugin/relativeTime'
import localizedFormat from 'dayjs/plugin/localizedFormat'

// lokalizācija
import 'dayjs/locale/en'
import 'dayjs/locale/lv'

dayjs.extend(relativeTime)
dayjs.extend(localizedFormat)

export default dayjs
