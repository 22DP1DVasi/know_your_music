<template>
    <AdminLayout>
        <div class="flex justify-between items-center mb-6">
            <h1>Create New User</h1>
            <Link :href="route('admin-users-index')" class="btn-secondary">
                Back to Users
            </Link>
        </div>

        <div class="bg-white rounded shadow p-6">
            <form @submit.prevent="submit">
                <div class="grid gap-6 mb-6">
                    <div>
                        <label for="name">Full Name</label>
                        <input
                            v-model="form.name"
                            id="name"
                            type="text"
                            class="input-field"
                            :class="{ 'input-error': form.errors.name }"
                        >
                        <div v-if="form.errors.name" class="error-message">
                            {{ form.errors.name }}
                        </div>
                    </div>

                    <div>
                        <label for="email">Email</label>
                        <input
                            v-model="form.email"
                            id="email"
                            type="email"
                            class="input-field"
                            :class="{ 'input-error': form.errors.email }"
                        >
                        <div v-if="form.errors.email" class="error-message">
                            {{ form.errors.email }}
                        </div>
                    </div>

                    <div>
                        <label for="password">Password</label>
                        <input
                            v-model="form.password"
                            id="password"
                            type="password"
                            class="input-field"
                            :class="{ 'input-error': form.errors.password }"
                        >
                        <div v-if="form.errors.password" class="error-message">
                            {{ form.errors.password }}
                        </div>
                    </div>

                    <div>
                        <label for="password_confirmation">Confirm Password</label>
                        <input
                            v-model="form.password_confirmation"
                            id="password_confirmation"
                            type="password"
                            class="input-field"
                        >
                    </div>

                    <div>
                        <label for="status">Status</label>
                        <select
                            v-model="form.status"
                            id="status"
                            class="input-field"
                            :class="{ 'input-error': form.errors.status }"
                        >
                            <option v-for="option in statusOptions" :value="option" :key="option">
                                {{ option }}
                            </option>
                        </select>
                        <div v-if="form.errors.status" class="error-message">
                            {{ form.errors.status }}
                        </div>
                    </div>

                    <div class="flex justify-end gap-4">
                        <button
                            type="button"
                            @click="resetForm"
                            class="btn-secondary"
                        >
                            Reset
                        </button>
                        <button
                            type="submit"
                            class="btn-primary"
                            :disabled="form.processing"
                        >
                            Create User
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>

<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';

const props = defineProps({
    statusOptions: Array
});

const form = useForm({
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    status: 'active'
});

const submit = () => {
    form.post(route('admin-users-store'));
};

const resetForm = () => {
    form.reset();
};

</script>

<style scoped>
.input-field {
    @apply w-full p-2 border rounded mt-1;
}

.input-error {
    @apply border-red-500;
}

.error-message {
    @apply text-red-500 text-sm mt-1;
}

.btn-primary {
    @apply bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700;
}

.btn-secondary {
    @apply bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600;
}

</style>
