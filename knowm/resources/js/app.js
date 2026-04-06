import '../css/app.css'
import './bootstrap'

import { createInertiaApp } from '@inertiajs/vue3'
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers'
import { createApp, h } from 'vue'
import { ZiggyVue } from 'ziggy-js'
import i18n from './i18n'

import ConfirmDialog from '@/Components/ConfirmDialog.vue'
import { useConfirm } from '@/composables/useConfirm'

const appName = import.meta.env.VITE_APP_NAME || 'Laravel'

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.vue`,
            import.meta.glob('./Pages/**/*.vue'),
        ),
    setup({ el, App, props, plugin }) {
        const vueApp = createApp({
            setup() {
                const {
                    visible,
                    options,
                    handleConfirm,
                    handleCancel
                } = useConfirm()

                return () => [
                    h(App, props),

                    h(ConfirmDialog, {
                        visible: visible.value,
                        'onUpdate:visible': (v) => (visible.value = v),
                        title: options.value.title,
                        message: options.value.message,
                        confirmText: options.value.confirmText || 'OK',
                        cancelText: options.value.cancelText || 'Cancel',
                        onConfirm: handleConfirm,
                        onCancel: handleCancel
                    })
                ]
            }
        })

        vueApp
            .use(plugin)
            .use(ZiggyVue)
            .use(i18n)

        return vueApp.mount(el)
    },
});
