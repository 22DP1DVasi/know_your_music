<script setup>
import { Link } from '@inertiajs/vue3';
import { computed } from 'vue';

const props = defineProps({
    links: {
        type: Array,
        default: () => []
    }
});

// iegūt pašreizējo lappuses numuru
const currentPage = computed(() => {
    const activeLink = props.links.find(link => link.active);
    return parseInt(activeLink?.label) || 1;
});

// iegūt lapu kopskaitu (izvilkt no pēdējās saites label'a)
const totalPages = computed(() => {
    if (props.links.length < 3) return 1;
    const lastPageLink = props.links[props.links.length - 2]; // otrais no pēdējās ir pēdējās lappuses numurs
    return parseInt(lastPageLink?.label) || 1;
});

// iegūt optimizētas lappušu numerācijas saites (vienmēr rādīt pirmo un pēdējo lappusi)
const optimizedLinks = computed(() => {
    if (totalPages.value <= 7) {
        // rādīt visas lapas, ja 7 vai mazāk
        const result = [];
        for (let i = 1; i <= totalPages.value; i++) {
            const link = props.links.find(l => l.label === i.toString() && l.url);
            if (link) {
                result.push(link);
            }
        }
        return result;
    }

    const result = [];
    const maxMiddlePages = 5; // maksimālais rādāmo vidējo lappušu skaits
    // vienmēr pievienot pirmo lapu
    const firstPageLink = props.links.find(l => l.label === '1' && l.url);
    if (firstPageLink) {
        result.push(firstPageLink);
    }
    // aprēķināt, kuras vidējās lappuses rādīt
    let startMiddle = Math.max(2, currentPage.value - 2);
    let endMiddle = Math.min(totalPages.value - 1, currentPage.value + 2)
    if (startMiddle === 2 && endMiddle < 2 + maxMiddlePages - 1) {
        endMiddle = Math.min(totalPages.value - 1, 2 + maxMiddlePages - 1);
    }
    if (endMiddle === totalPages.value - 1 && startMiddle > totalPages.value - maxMiddlePages) {
        startMiddle = Math.max(2, totalPages.value - maxMiddlePages + 1);
    }
    // ja nepieciešams, pievienot punktus pēc pirmās lappuses
    if (startMiddle > 2) {
        result.push({ label: '...', url: null, active: false });
    }
    // pievienot vidējās lappuses
    for (let i = startMiddle; i <= endMiddle; i++) {
        const link = props.links.find(l => l.label === i.toString() && l.url);
        if (link) {
            result.push(link);
        }
    }
    // ja nepieciešams, pirms pēdējās lappuses pievienot punktus
    if (endMiddle < totalPages.value - 1) {
        result.push({ label: '...', url: null, active: false });
    }
    // vienmēr pievienot pēdējo lapu
    const lastPageLink = props.links.find(l => l.label === totalPages.value.toString() && l.url);
    if (lastPageLink) {
        result.push(lastPageLink);
    }
    return result;
});

// pārbaudīt, vai ir jārāda lappušu numerācija
const shouldShowPagination = computed(() => {
    return totalPages.value > 1;
});

</script>

<template>
    <div v-if="shouldShowPagination" class="admin-pagination">
        <div class="pagination-links">
            <Link
                v-if="links[0] && links[0].url"
                :href="links[0].url"
                class="pagination-link pagination-arrow"
                :class="{ 'disabled': !links[0].url }"
                preserve-scroll
                v-html="links[0].label"
            />

            <template v-for="(link, index) in optimizedLinks" :key="index">
                <Link
                    v-if="link.url"
                    :href="link.url"
                    class="pagination-link"
                    :class="{ 'active': link.active, 'disabled': !link.url }"
                    preserve-scroll
                >
                    {{ link.label }}
                </Link>
                <span
                    v-else-if="link.label === '...'"
                    class="pagination-dots"
                    v-html="link.label"
                />
                <span
                    v-else-if="!link.url && link.label !== '...'"
                    class="pagination-link disabled"
                    v-html="link.label"
                />
            </template>

            <Link
                v-if="links[links.length - 1] && links[links.length - 1].url"
                :href="links[links.length - 1].url"
                class="pagination-link pagination-arrow"
                :class="{ 'disabled': !links[links.length - 1].url }"
                preserve-scroll
                v-html="links[links.length - 1].label"
            />
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
    gap: 0.25rem;
    align-items: center;
}

.pagination-link {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 2.5rem;
    height: 2.5rem;
    padding: 0 0.25rem;
    border-radius: 0.375rem;
    background-color: #f8f9fa;
    color: #6b7280;
    text-decoration: none;
    font-weight: 500;
    font-size: 0.875rem;
    border: 1px solid #e5e7eb;
    transition: all 0.2s ease-in-out;
    cursor: pointer;
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

.pagination-link.pagination-arrow {
    min-width: 2.5rem;
    font-size: 1.2rem;
    font-weight: bold;
    padding: 0;
}

.pagination-dots {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 1.5rem;
    height: 2.5rem;
    color: #9ca3af;
    font-weight: bold;
    user-select: none;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .admin-pagination {
        padding: 0 1rem 1rem;
    }

    .pagination-links {
        flex-wrap: wrap;
        justify-content: center;
        gap: 0.125rem;
    }

    .pagination-link {
        min-width: 2rem;
        height: 2rem;
        font-size: 0.75rem;
        padding: 0 0.125rem;
    }

    .pagination-link.pagination-arrow {
        min-width: 2rem;
        font-size: 1rem;
    }

    .pagination-dots {
        min-width: 1rem;
        padding: 0 0.125rem;
    }
}

@media (max-width: 480px) {
    .pagination-link {
        min-width: 1.75rem;
        height: 1.75rem;
        font-size: 0.7rem;
    }

    .pagination-link.pagination-arrow {
        min-width: 1.75rem;
    }
}

</style>
