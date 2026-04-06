<script setup>
import { watch } from 'vue';

const props = defineProps({
    visible: {
        type: Boolean,
        default: true
    },
    title: {
        type: String,
        default: 'Confirm Action'
    },
    message: {
        type: String,
        required: true
    },
    confirmText: {
        type: String,
        default: 'OK'
    },
    cancelText: {
        type: String,
        default: 'Cancel'
    },
    closeOnEscape: {
        type: Boolean,
        default: true
    }
});

const emit = defineEmits(['confirm', 'cancel', 'update:visible']);

const handleConfirm = () => {
    emit('confirm');
    emit('update:visible', false);
};

const handleCancel = () => {
    emit('cancel');
    emit('update:visible', false);
};

// Handle escape key
const handleEscape = (event) => {
    if (props.closeOnEscape && event.key === 'Escape' && props.visible) {
        handleCancel();
    }
};

// Add/remove escape key listener
watch(() => props.visible, (newVal) => {
    if (newVal) {
        document.addEventListener('keydown', handleEscape);
        // Prevent body scroll when dialog is open
        document.body.style.overflow = 'hidden';
    } else {
        document.removeEventListener('keydown', handleEscape);
        document.body.style.overflow = '';
    }
}, { immediate: true });

</script>

<template>
    <Teleport to="body">
        <Transition name="dialog-fade">
            <div v-if="visible" class="dialog-overlay" @click.self="handleCancel">
                <div class="dialog-container">
                    <div class="dialog-header">
                        <div class="dialog-icon">
                            <i class="fa-regular fa-circle-question"></i>
                        </div>
                        <button class="dialog-close" @click="handleCancel">
                            <i class="fa-regular fa-circle-xmark"></i>
                        </button>
                    </div>

                    <div class="dialog-content">
                        <h3 class="dialog-title">{{ title }}</h3>
                        <p class="dialog-message">{{ message }}</p>
                    </div>

                    <div class="dialog-footer">
                        <button class="dialog-button cancel" @click="handleCancel">
                            <i class="fa-solid fa-x"></i>
                            {{ cancelText }}
                        </button>
                        <button class="dialog-button confirm" @click="handleConfirm" autofocus>
                            <i class="fa-solid fa-check"></i>
                            {{ confirmText }}
                        </button>
                    </div>
                </div>
            </div>
        </Transition>
    </Teleport>
</template>

<style scoped>
.dialog-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(4px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
    padding: 1rem;
}

.dialog-container {
    max-width: 400px;
    width: 100%;
    background: white;
    border-radius: 24px;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    overflow: hidden;
    animation: dialogSlideIn 0.3s cubic-bezier(0.2, 0.9, 0.4, 1.1);
}

@keyframes dialogSlideIn {
    from {
        opacity: 0;
        transform: scale(0.95) translateY(-20px);
    }
    to {
        opacity: 1;
        transform: scale(1) translateY(0);
    }
}

.dialog-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.25rem 1.25rem 0 1.25rem;
}

.dialog-icon {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, rgba(12, 75, 170, 0.1), rgba(32, 193, 247, 0.1));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
}

.dialog-icon i {
    font-size: 1.5rem;
    color: #0c4baa;
}

.dialog-close {
    background: transparent;
    border: none;
    width: 32px;
    height: 32px;
    font-size: 2rem;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    color: #94a3b8;
    transition: all 0.2s ease;
}

.dialog-close:hover {
    background: #f1f5f9;
    color: #475569;
}

.dialog-content {
    padding: 1rem 1.25rem 1.5rem 1.25rem;
    text-align: center;
}

.dialog-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 0.5rem;
}

.dialog-message {
    font-size: 0.95rem;
    color: #475569;
    line-height: 1.5;
    margin: 0;
}

.dialog-footer {
    display: flex;
    gap: 0.75rem;
    padding: 1rem 1.25rem 1.25rem 1.25rem;
    background: #f8fafc;
    border-top: 1px solid #eef2f6;
}

.dialog-button {
    flex: 1;
    padding: 0.625rem 1rem;
    border-radius: 40px;
    font-size: 0.9rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    border: none;
}

.dialog-button.cancel {
    background: white;
    color: #64748b;
    border: 1px solid #e2e8f0;
}

.dialog-button.cancel:hover {
    background: #f1f5f9;
    border-color: #cbd5e1;
    transform: translateY(-1px);
}

.dialog-button.confirm {
    background: linear-gradient(135deg, #0c4baa, #20c1f7);
    color: white;
    box-shadow: 0 2px 8px rgba(12, 75, 170, 0.2);
}

.dialog-button.confirm:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(12, 75, 170, 0.3);
}

.dialog-button:active {
    transform: translateY(0);
}

.dialog-fade-enter-active,
.dialog-fade-leave-active {
    transition: opacity 0.3s ease;
}

.dialog-fade-enter-from,
.dialog-fade-leave-to {
    opacity: 0;
}

.dialog-fade-enter-from .dialog-container,
.dialog-fade-leave-to .dialog-container {
    transform: scale(0.95) translateY(-20px);
}

/* Responsivitāte */
@media (max-width: 480px) {
    .dialog-container {
        max-width: 90%;
    }

    .dialog-content {
        padding: 1rem 1rem 1.25rem 1rem;
    }

    .dialog-footer {
        flex-direction: column;
        gap: 0.5rem;
    }

    .dialog-button {
        padding: 0.75rem 1rem;
    }
}

</style>
