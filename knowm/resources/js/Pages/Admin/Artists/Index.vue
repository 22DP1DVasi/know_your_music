<template>
    <AdminLayout>
        <div class="flex justify-between items-center mb-6">
            <h1>Artists</h1>
            <Link :href="route('admin.artists.create')" class="btn-primary">
                Add New Artist
            </Link>
        </div>

        <div class="bg-white rounded shadow overflow-x-auto">
            <table class="w-full">
                <thead>
                <tr class="bg-gray-100">
                    <th class="px-6 py-3 text-left">Name</th>
                    <th class="px-6 py-3 text-left">Type</th>
                    <th class="px-6 py-3 text-left">Actions</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="artist in artists.data" :key="artist.id">
                    <td class="px-6 py-4">{{ artist.name }}</td>
                    <td class="px-6 py-4">{{ artist.solo_or_band }}</td>
                    <td class="px-6 py-4 flex gap-2">
                        <Link :href="route('admin.artists.edit', artist.id)" class="btn-edit">
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
        router.delete(route('admin.artists.destroy', id));
    }
};

</script>
