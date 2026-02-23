<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
import DeleteUserForm from './Partials/DeleteUserForm.vue';
import UpdatePasswordForm from './Partials/UpdatePasswordForm.vue';
import UpdateProfileInformationForm from './Partials/UpdateProfileInformationForm.vue';
import { Head } from '@inertiajs/vue3';

defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

</script>

<template>
    <Head title="Profile" />

    <AuthenticatedLayout>
        <template #header>
            <h2 class="profile-header">
                Profile
            </h2>
        </template>

        <div class="profile-container">
            <div class="profile-content">
                <div class="profile-card">
                    <UpdateProfileInformationForm
                        :must-verify-email="mustVerifyEmail"
                        :status="status"
                        class="form-container"
                    />
                </div>

                <div class="profile-card">
                    <UpdatePasswordForm class="form-container" />
                </div>

                <div class="profile-card">
                    <DeleteUserForm class="form-container" />
                </div>
            </div>
        </div>
    </AuthenticatedLayout>
</template>

<style scoped>
.profile-header {
    font-size: 1.5rem;
    font-weight: 600;
    color: #0c4baa;
    margin: 0;
}

.profile-container {
    padding-top: 2rem;
    padding-bottom: 3rem;
}

.profile-content {
    max-width: 80rem;
    margin-left: auto;
    margin-right: auto;
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.profile-card {
    background-color: #ffffff;
    padding: 1rem;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
}

.form-container {
    max-width: 36rem;
}

/* Responsivitāte */
@media (min-width: 1024px) {
    .profile-content {
        padding-left: 2rem;
        padding-right: 2rem;
    }
}

@media (min-width: 640px) {
    .profile-content {
        padding-left: 1.5rem;
        padding-right: 1.5rem;
    }

    .profile-card {
        border-radius: 0.5rem;
        padding: 2rem;
    }
}

</style>
