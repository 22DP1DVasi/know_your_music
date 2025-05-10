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
                        {{ role.name }};
                      </span>
                    </td>
                    <td class="px-6 py-4">{{ user.created_at }}</td>
                    <td class="px-6 py-4">{{ user.updated_at }}</td>
                    <td class="px-6 py-4 flex gap-2">
                        <Link :href="route('admin-users-edit', { id: user.id })" class="btn-edit">
                            Edit
                        </Link>
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
import { Link } from '@inertiajs/vue3';

defineProps({
    users: Object
});

</script>
