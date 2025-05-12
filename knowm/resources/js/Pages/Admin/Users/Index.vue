<template>
    <AdminLayout>
        <div class="flex justify-between items-center mb-6">
            <h1>User Management</h1>
            <Link :href="route('admin-users-create')" class="btn-primary">
                Add New User
            </Link>
        </div>

        <div class="bg-white rounded shadow overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="bg-gray-100">
                    <th class="px-6 py-3 text-left">ID</th>
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Email</th>
                    <th class="px-6 py-3 text-left">Status</th>
                    <th class="px-6 py-3 text-left">Roles</th>
                    <th class="px-6 py-3 text-left">Created at</th>
                    <th class="px-6 py-3 text-left">Updated at</th>
                    <th class="px-6 py-3 text-left">Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="user in users.data" :key="user.id">
                    <td class="px-6 py-4">{{ user.id }}</td>
                    <td class="px-6 py-4">{{ user.name }}</td>
                    <td class="px-6 py-4">{{ user.email }}</td>
                    <td class="px-6 py-4">{{ user.status }}</td>
                    <td class="px-6 py-4">
                      <span v-for="role in user.roles" :key="role.id" class="role-pill">
                        {{ role.name }}
                      </span>
                    </td>
                    <td class="px-6 py-4">{{ user.created_at }}</td>
                    <td class="px-6 py-4">{{ user.updated_at }}</td>
                    <td class="px-6 py-4 flex gap-2">
                        <Link :href="route('admin-users-edit', { id: user.id })" class="btn-edit">
                            Edit
                        </Link>
                        <button @click="deleteUser(user.id)" class="btn-danger">
                            Delete
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>

            <Pagination :links="users.links" class="mt-4" />
        </div>
    </AdminLayout>
</template>

<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';

defineProps({
    users: Object
});

const deleteUser = (id) => {
    if (confirm('Are you sure you want to delete this user?')) {
        router.delete(route('admin-users-destroy', { id: id }), {
            onSuccess: () => {
            },
            onError: (errors) => {
                alert(errors.response.data.message || "");
            },
            preserveScroll: true
        });
    }
};

const formatDate = (dateString) => {
    if (!dateString) return '';
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    return new Date(dateString).toLocaleDateString(undefined, options);
};

</script>

<style scoped>

.role-pill {
    @apply bg-gray-200 text-gray-800 text-xs px-2 py-1 rounded mr-1 mb-1 inline-block;
}

.flex.gap-2 {
    gap: 0.5rem;
}

.error-message {
    @apply bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded;
}

tr.error-row {
    @apply bg-red-50;
}

</style>
