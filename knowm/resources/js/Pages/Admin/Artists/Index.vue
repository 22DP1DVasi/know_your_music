<template>
    <AdminLayout>
        <div class="flex justify-between items-center mb-6">
            <h1>Artist Management</h1>
            <Link :href="route('home')" class="btn-secondary">
                Back to website
            </Link>
            <Link :href="route('admin-artists-create')" class="btn-primary">
                Add New Artist
            </Link>
        </div>

        <div class="bg-white rounded shadow overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="bg-gray-100">
                    <th class="px-6 py-3 text-left">ID</th>
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Type</th>
                    <th class="px-6 py-3 text-left">Years Active</th>
                    <th class="px-6 py-3 text-left">Status</th>
                    <th class="px-6 py-3 text-left">Created at</th>
                    <th class="px-6 py-3 text-left">Updated at</th>
                    <th class="px-6 py-3 text-left">Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="artist in artists.data" :key="artist.id">
                    <td class="px-6 py-4">{{ artist.id }}</td>
                    <td class="px-6 py-4">{{ artist.name }}</td>
                    <td class="px-6 py-4">{{ artist.solo_or_band || '-' }}</td>
                    <td class="px-6 py-4">
                        <span v-if="artist.formed_year">
                            {{ artist.formed_year }}
                            <span v-if="artist.disbanded_year">- {{ artist.disbanded_year }}</span>
                            <span v-else>- Present</span>
                        </span>
                        <span v-else>-</span>
                    </td>
                    <td class="px-6 py-4">
                        <span>
                            {{ artist.is_active ? 'Active' : 'Inactive' }}
                        </span>
                    </td>
                    <td class="px-6 py-4">{{ artist.created_at }}</td>
                    <td class="px-6 py-4">{{ artist.updated_at }}</td>
                    <td class="px-6 py-4 flex gap-2">
                        <Link :href="route('admin-artists-edit', { id: artist.id })" class="btn-edit">
                            Edit
                        </Link>
                        <button @click="deleteArtist(artist.id)" class="btn-danger">
                            Delete
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>

            <Pagination :links="artists.links" class="mt-4" />
        </div>
    </AdminLayout>
</template>

<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';

defineProps({
    artists: Object
});

const deleteArtist = (id) => {
    if (confirm('Are you sure you want to delete this artist?')) {
        router.delete(route('admin-artists-destroy', { id: id }), {
            onSuccess: () => {
            },
            onError: (errors) => {
                alert(errors.response.data.message || "Could not delete artist");
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
.flex.gap-2 {
    gap: 0.5rem;
}

</style>
