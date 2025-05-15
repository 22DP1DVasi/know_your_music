<template>
    <div v-if="show" class="audio-player">
        <button @click="close" class="close-player">
            <i class="fa-solid fa-times"></i>
        </button>
        <iframe
            :src="source"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
        ></iframe>
    </div>
</template>

<script setup>
import { ref } from 'vue';

const props = defineProps({
    source: {
        type: String,
        default: ''
    },
    show: {
        type: Boolean,
        default: false
    }
});

const emit = defineEmits(['close']);

const close = () => {
    emit('close');
};

</script>

<style scoped>
.audio-player {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 360px;
    height: 200px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 1000;
    overflow: hidden;
    transition: all 0.3s ease;
}

.audio-player iframe {
    width: 100%;
    height: 100%;
}

.close-player {
    position: absolute;
    top: 8px;
    right: 8px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    border: none;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    z-index: 1001;
}

.close-player:hover {
    background: rgba(0, 0, 0, 0.9);
}

</style>
