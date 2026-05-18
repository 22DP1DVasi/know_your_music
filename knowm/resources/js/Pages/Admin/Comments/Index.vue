<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, router } from '@inertiajs/vue3';
import Pagination from "@/Components/Admin/Pagination.vue";
import { ref, watch, computed } from 'vue';
import { debounce } from 'lodash';
import { useI18n } from 'vue-i18n';
import axios from 'axios';
import dayjs from 'dayjs';

const props = defineProps({
    comments: Object,
    filters: {
        type: Object,
        default: () => ({
            type: 'artists',
            status: '',
            search: ''
        })
    }
});

const { t } = useI18n();

// filter bindings
const commentType = ref(props.filters.type || 'artists');
const statusFilter = ref(props.filters.status || '');
const searchQuery = ref(props.filters.search || '');

// update filters and reload
const updateFilters = () => {
    const params = {
        type: commentType.value,
        status: statusFilter.value,
        search: searchQuery.value,
    };
    // remove empty values
    Object.keys(params).forEach(key => !params[key] && delete params[key]);

    router.get(route('admin-comments'), params, {
        preserveState: true,
        replace: true,
        preserveScroll: true,
        only: ['comments', 'filters']
    });
};

// debounced search
const debouncedSearch = debounce(updateFilters, 400);

watch(commentType, updateFilters);
watch(statusFilter, updateFilters);
watch(searchQuery, (val) => {
    if (val === '' || val.length >= 1) debouncedSearch();
});

const clearFilters = () => {
    commentType.value = 'artists';
    statusFilter.value = '';
    searchQuery.value = '';
    updateFilters();
};

const hasActiveFilters = computed(() => {
    return commentType.value !== 'artists' || statusFilter.value !== '' || searchQuery.value !== '';
});

const formatDate = (date) => {
    if (!date) return '';
    return dayjs(date).format('YYYY-MM-DD HH:mm:ss');
};

// update comment status
const toggleStatus = async (comment, type) => {
    const newStatus = comment.status === 'visible' ? 'hidden' : 'visible';
    try {
        await axios.patch(route('admin-comments.update-status', { type: type, id: comment.id }), {
            status: newStatus
        });
        // update local comment status
        comment.status = newStatus;
    } catch (error) {
        console.error(error);
        alert(t('adm_comments.error_update_status'));
    }
};

// WIP
const getParentReference = (comment) => {
    if (!comment.parent_id) return null;
    return {
        id: comment.parent_id,
        // we don't have parent text here, just the ID.
    };
};
</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_comments.title') }}</h1>
            <div class="header-actions">
                <Link :href="route('home')" class="btn-secondary">
                    {{ t('adm_comments.back_to_website') }}
                </Link>
            </div>
        </div>

        <div class="filters-container">
            <div class="filters-grid">
                <div class="filter-group">
                    <label>{{ t('adm_comments.type_label') }}</label>
                    <select v-model="commentType" class="input-field">
                        <option value="artists">{{ t('adm_comments.type_artists') }}</option>
                        <option value="releases">{{ t('adm_comments.type_releases') }}</option>
                        <option value="tracks">{{ t('adm_comments.type_tracks') }}</option>
                        <option value="genres">{{ t('adm_comments.type_genres') }}</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>{{ t('adm_comments.status_label') }}</label>
                    <select v-model="statusFilter" class="input-field">
                        <option value="">{{ t('adm_comments.status_all') }}</option>
                        <option value="visible">{{ t('adm_comments.status_visible') }}</option>
                        <option value="hidden">{{ t('adm_comments.status_hidden') }}</option>
                        <option value="deleted">{{ t('adm_comments.status_deleted') }}</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>{{ t('adm_comments.search_label') }}</label>
                    <div class="search-input-wrapper">
                        <input
                            v-model="searchQuery"
                            type="text"
                            class="input-field"
                            :placeholder="t('adm_comments.search_placeholder')"
                        />
                        <button
                            v-if="searchQuery"
                            @click="searchQuery = ''"
                            class="clear-search-btn"
                            type="button"
                        >
                            ×
                        </button>
                    </div>
                </div>

                <div class="filter-group filter-actions">
                    <button
                        v-if="hasActiveFilters"
                        @click="clearFilters"
                        class="btn-clear-filters"
                        type="button"
                    >
                        {{ t('adm_comments.clear_filter_btn') }}
                    </button>
                </div>
            </div>
        </div>

        <div class="comments-list">
            <div v-for="comment in comments.data" :key="comment.id" class="comment-card"
                 :class="{ 'deleted-comment': comment.deleted_at }">
                <!-- Top row: badges -->
                <div class="comment-header">
                    <div class="badge-group">
                        <span class="badge badge-id">#{{ comment.id }}</span>
                        <span v-if="comment.deleted_at" class="badge badge-deleted">
                            {{ t('adm_comments.badge_deleted') }}
                        </span>
                        <span v-else :class="['badge', comment.status === 'visible' ? 'badge-visible' : 'badge-hidden']">
                            {{ comment.status === 'visible' ? t('adm_comments.visible') : t('adm_comments.hidden') }}
                        </span>
                        <span v-if="comment.edited_at" class="badge badge-edited">
                            {{ t('adm_comments.badge_edited') }}
                        </span>
                    </div>
                    <div class="comment-meta">
                        <span class="user-name">{{ comment.user?.name || t('adm_comments.anonymous') }}</span>
                        <span class="comment-date">{{ formatDate(comment.created_at) }}</span>
                    </div>
                </div>

                <!-- Parent reference if exists -->
                <div v-if="comment.parent_id" class="parent-ref">
                    ↳ {{ t('adm_comments.reply_to') }} #{{ comment.parent_id }}
                </div>

                <!-- Comment text -->
                <div class="comment-text">{{ comment.text }}</div>

                <!-- Bottom actions -->
                <div class="comment-actions" v-if="!comment.deleted_at">
                    <button @click="toggleStatus(comment, commentType)" class="btn-status">
                        <template v-if="comment.status === 'visible'">
                            {{ t('adm_comments.hide_btn') }}
                        </template>
                        <template v-else>
                            {{ t('adm_comments.show_btn') }}
                        </template>
                    </button>
                </div>
                <div v-else class="deleted-note">
                    {{ t('adm_comments.deleted_note') }}
                </div>
            </div>

            <div v-if="comments.data?.length === 0" class="no-results">
                <template v-if="hasActiveFilters">
                    <p>{{ t('adm_comments.search_not_found') }}</p>
                    <button @click="clearFilters" class="text-link">
                        {{ t('adm_comments.clear_filters_msg') }}
                    </button>
                </template>
                <template v-else>
                    <p>{{ t('adm_comments.no_comments_found') }}</p>
                </template>
            </div>
        </div>

        <Pagination :links="comments.links" class="pagination" />
    </AdminLayout>
</template>

<style scoped>
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
    flex-wrap: wrap;
    gap: 1rem;
}

.header-container h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

.header-actions {
    display: flex;
    gap: 0.75rem;
}

.btn-secondary {
    background-color: #6b7280;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    text-decoration: none;
    font-weight: 500;
    transition: background 0.2s;
    border: none;
    cursor: pointer;
}
.btn-secondary:hover {
    background-color: #4b5563;
}

.filters-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    padding: 1.5rem;
    margin-bottom: 1.5rem;
}

.filters-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.5rem;
    align-items: end;
}

.filter-group {
    display: flex;
    flex-direction: column;
}

.filter-group label {
    font-weight: 500;
    font-size: 0.875rem;
    margin-bottom: 0.25rem;
}

.search-input-wrapper {
    position: relative;
}

.clear-search-btn {
    position: absolute;
    right: 0.5rem;
    top: 50%;
    transform: translateY(-50%);
    background: none;
    border: none;
    font-size: 1.2rem;
    cursor: pointer;
    color: #9ca3af;
}

.input-field {
    width: 100%;
    padding: 0.5rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
}

.filter-actions {
    justify-content: flex-end;
}

.btn-clear-filters {
    background-color: #ef4444;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    cursor: pointer;
}
.btn-clear-filters:hover {
    background-color: #dc2626;
}

.comments-list {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.comment-card {
    background: white;
    border-radius: 0.75rem;
    padding: 1.25rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    transition: all 0.2s;
}

.comment-card.deleted-comment {
    opacity: 0.7;
    background-color: #f9fafb;
}

.comment-header {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 0.75rem;
    margin-bottom: 0.75rem;
}

.badge-group {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.badge {
    display: inline-block;
    padding: 0.2rem 0.6rem;
    border-radius: 9999px;
    font-size: 0.75rem;
    font-weight: 500;
}

.badge-id {
    background: #e5e7eb;
    color: #1f2937;
}

.badge-visible {
    background: #d1fae5;
    color: #065f46;
}

.badge-hidden {
    background: #fee2e2;
    color: #991b1b;
}

.badge-deleted {
    background: #e5e7eb;
    color: #374151;
}

.badge-edited {
    background: #dbeafe;
    color: #1e40af;
}

.comment-meta {
    font-size: 0.8rem;
    color: #6b7280;
    display: flex;
    gap: 0.75rem;
}

.user-name {
    font-weight: 500;
    color: #374151;
}

.parent-ref {
    font-size: 0.8rem;
    color: #6b7280;
    margin-bottom: 0.5rem;
    padding-left: 0.5rem;
    border-left: 2px solid #e5e7eb;
}

.comment-text {
    margin-top: 0.5rem;
    white-space: pre-wrap;
    word-break: break-word;
    font-size: 0.9rem;
    line-height: 1.5;
}

.comment-actions {
    margin-top: 1rem;
    text-align: right;
}

.btn-status {
    background: none;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    padding: 0.25rem 0.75rem;
    font-size: 0.75rem;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-status:hover {
    background-color: #f3f4f6;
}

.deleted-note {
    margin-top: 1rem;
    font-size: 0.75rem;
    color: #9ca3af;
    font-style: italic;
}

.no-results {
    text-align: center;
    padding: 3rem;
    color: #6b7280;
}

.pagination {
    margin-top: 1.5rem;
}

.text-link {
    background: none;
    border: none;
    color: #3b82f6;
    text-decoration: underline;
    cursor: pointer;
}

/* Responsive design */
@media (max-width: 768px) {
    .filters-grid {
        grid-template-columns: 1fr;
    }
    .comment-header {
        flex-direction: column;
        align-items: flex-start;
    }
}

</style>
