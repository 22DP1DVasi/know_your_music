<template>
    <form @submit.prevent="submit">
        <div class="grid gap-6 mb-6">
            <div>
                <label for="name">Artist Name</label>
                <input v-model="form.name" id="name" type="text">
                <div v-if="form.errors.name" class="error">{{ form.errors.name }}</div>
            </div>

            <div>
                <label for="type">Type</label>
                <select v-model="form.solo_or_band" id="type">
                    <option value="solo">Solo Artist</option>
                    <option value="band">Band</option>
                </select>
            </div>

            <!-- Add more fields as needed -->

            <div class="flex justify-end gap-4">
                <button type="button" @click="cancel" class="btn-secondary">
                    Cancel
                </button>
                <button type="submit" class="btn-primary" :disabled="form.processing">
                    Save
                </button>
            </div>
        </div>
    </form>
</template>

<script setup>
import { useForm } from '@inertiajs/vue3';

const props = defineProps({
    artist: {
        type: Object,
        default: () => ({
            name: '',
            solo_or_band: 'solo'
        })
    }
});

const form = useForm({
    name: props.artist.name,
    solo_or_band: props.artist.solo_or_band
});

const emit = defineEmits(['cancel']);

const submit = () => {
    if (props.artist.id) {
        form.put(route('admin.artists.update', props.artist.id));
    } else {
        form.post(route('admin.artists.store'));
    }
};

const cancel = () => {
    emit('cancel');
};

</script>
