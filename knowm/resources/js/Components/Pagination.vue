<template>
    <div v-if="totalPages > 1" class="pagination-container">
        <div class="pagination">
            <a
                v-for="(link, index) in links"
                :key="index"
                :href="link.url"
                class="page-link"
                :class="{
          'active': link.active,
          'disabled': !link.url
        }"
                v-html="link.label"
            />
        </div>

        <div v-if="totalPages > 1" class="page-info">
            Page {{ currentPage }} of {{ totalPages }}
        </div>
    </div>
</template>

<script setup>
defineProps({
    links: Array,
    currentPage: Number,
    totalPages: Number
});
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
}
</style>
