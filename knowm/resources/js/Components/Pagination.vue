<template>
    <div v-if="totalPages > 1" class="pagination-container">
        <div class="pagination">
            <Link
                v-for="(link, index) in links"
                :key="index"
                :href="link.url ? `${link.url}&q=${searchQuery}` : null"
                class="page-link"
                :class="{
                    'active': link.active,
                    'disabled': !link.url
                }"
                v-html="formatLabel(link.label)"
                preserve-state
            />
        </div>
    </div>
</template>

<script setup>
import { Link } from '@inertiajs/vue3';

const props = defineProps({
    links: Array,
    currentPage: Number,
    totalPages: Number,
    searchQuery: String
});

const formatLabel = (label) => {
    if (label.includes('Previous')) return '&laquo;';
    if (label.includes('Next')) return '&raquo;';
    return label;
};
</script>

<style scoped>
.pagination-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 1rem;
}

.pagination {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.page-link {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 50%;
    background-color: #f5f5f5;
    color: #0c4baa;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s ease;
}

.page-link:hover:not(.active, .disabled) {
    background-color: #e0e0e0;
}

.page-link.active {
    background-color: #0c4baa;
    color: white;
}

.page-link.disabled {
    color: #999;
    cursor: not-allowed;
    opacity: 0.6;
    pointer-events: none;
}

/* Special styling for navigation links */
.page-link.nav-link {
    font-size: 1.2rem;
    padding: 0.5rem;
}

.page-info {
    color: #666;
    font-size: 0.9rem;
}

@media (max-width: 768px) {
    .pagination {
        flex-wrap: wrap;
        justify-content: center;
    }

    .page-link {
        width: 2.25rem;
        height: 2.25rem;
        font-size: 0.9rem;
    }

    .page-link.nav-link {
        font-size: 1rem;
    }
}
</style>
