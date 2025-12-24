<script setup>
import { Link } from '@inertiajs/vue3';

defineProps({
    links: {
        type: Array,
        default: () => []
    }
});

</script>

<template>
    <div v-if="links.length > 3" class="admin-pagination">
        <div class="pagination-links">
            <template v-for="(link, index) in links" :key="index">
                <Link
                    v-if="link.url"
                    :href="link.url"
                    class="pagination-link"
                    :class="{ 'active': link.active, 'disabled': !link.url }"
                    v-html="link.label"
                    preserve-scroll
                />
                <span
                    v-else
                    class="pagination-link disabled"
                    v-html="link.label"
                />
            </template>
        </div>
    </div>
</template>

<style scoped>
.admin-pagination {
    display: flex;
    justify-content: center;
    margin-top: 2rem;
    padding: 0 1.5rem 1.5rem;
}

.pagination-links {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.pagination-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 2.5rem;
    height: 2.5rem;
    padding: 0 0.75rem;
    border-radius: 0.375rem;
    background-color: #f8f9fa;
    color: #6b7280;
    text-decoration: none;
    font-weight: 500;
    font-size: 0.875rem;
    border: 1px solid #e5e7eb;
    transition: all 0.2s ease-in-out;
}

.pagination-link:hover:not(.active, .disabled) {
    background-color: #e5e7eb;
    color: #374151;
    border-color: #d1d5db;
}

.pagination-link.active {
    background-color: #3b82f6;
    color: white;
    border-color: #3b82f6;
}

.pagination-link.disabled {
    color: #9ca3af;
    cursor: not-allowed;
    opacity: 0.6;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .admin-pagination {
        padding: 0 1rem 1rem;
    }

    .pagination-links {
        flex-wrap: wrap;
        justify-content: center;
    }

    .pagination-link {
        min-width: 2.25rem;
        height: 2.25rem;
        font-size: 0.8rem;
        padding: 0 0.5rem;
    }
}

</style>
