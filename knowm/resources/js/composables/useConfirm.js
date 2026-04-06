import { ref } from 'vue'

const visible = ref(false)
const options = ref({})
let resolvePromise = null

export function useConfirm() {
    const confirm = (opts) => {
        options.value = opts
        visible.value = true

        return new Promise((resolve) => {
            resolvePromise = resolve
        })
    }

    const handleConfirm = () => {
        visible.value = false
        resolvePromise?.(true)
    }

    const handleCancel = () => {
        visible.value = false
        resolvePromise?.(false)
    }

    return {
        confirm,
        visible,
        options,
        handleConfirm,
        handleCancel
    }
}
