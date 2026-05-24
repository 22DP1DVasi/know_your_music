<script setup>
import { reactive } from 'vue';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import AdminLayout from '@/Layouts/AdminLayout.vue';
import {Link} from "@inertiajs/vue3";

const { t } = useI18n();

// users Report filters
const usersReport = reactive({
    limit: 100,
    date_from: '',
    date_to: ''
});

// comments Report filters
const commentsReport = reactive({
    limit: 100,
    date_from: '',
    date_to: '',
    status: 'all' // 'all', 'visible', 'hidden'
});

// popular Artists Report filters
const popularArtistsReport = reactive({
    limit: 50,
    min_popularity: '',
    activity_status: 'all'
});

const generateUsersReport = () => {
    const params = new URLSearchParams({
        limit: usersReport.limit,
        date_from: usersReport.date_from,
        date_to: usersReport.date_to
    });
    window.open(route('admin-reports-users') + '?' + params.toString(), '_blank');
};

const generateCommentsReport = () => {
    const params = new URLSearchParams({
        limit: commentsReport.limit,
        date_from: commentsReport.date_from,
        date_to: commentsReport.date_to
    });
    window.open(route('admin-reports-comments') + '?' + params.toString(), '_blank');
};

const generatePopularArtistsReport = () => {
    const params = new URLSearchParams({
        limit: popularArtistsReport.limit,
        min_popularity: popularArtistsReport.min_popularity,
        activity_status: popularArtistsReport.activity_status
    });
    window.open(route('admin-reports-popular-artists') + '?' + params.toString(), '_blank');
};

</script>

<template>
    <AdminLayout>
        <div class="reports-container">
            <div class="header-container">
                <h1>{{ t('adm_reports.title') }}</h1>
                <div class="header-actions">
                    <Link :href="route('home')" class="btn-secondary">
                        {{ t('adm_reports.back_to_website') }}
                    </Link>
                </div>
            </div>

            <!-- Users Report Card -->
            <div class="report-card">
                <div class="report-header">
                    <div>
                        <h3 class="report-title">{{ t('adm_reports.users_title') }}</h3>
                        <p class="report-description">{{ t('adm_reports.users_description') }}</p>
                    </div>
                </div>

                <div class="report-filters">
                    <div class="form-group">
                        <label>{{ t('adm_reports.record_limit') }}</label>
                        <select v-model="usersReport.limit" class="input-field">
                            <option :value="25">25</option>
                            <option :value="50">50</option>
                            <option :value="100">100</option>
                            <option :value="250">250</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>{{ t('adm_reports.date_from') }}</label>
                        <input type="date" v-model="usersReport.date_from" class="input-field" />
                    </div>

                    <div class="form-group">
                        <label>{{ t('adm_reports.date_to') }}</label>
                        <input type="date" v-model="usersReport.date_to" class="input-field" />
                    </div>
                </div>

                <div class="report-actions">
                    <button type="button" class="btn-primary" @click="generateUsersReport">
                        {{ t('adm_reports.generate_pdf') }}
                    </button>
                </div>
            </div>

            <!-- Comments Report Card -->
            <div class="report-card">
                <div class="report-header">
                    <div>
                        <h3 class="report-title">{{ t('adm_reports.comments_title') }}</h3>
                        <p class="report-description">{{ t('adm_reports.comments_description') }}</p>
                    </div>
                </div>

                <div class="report-filters">
                    <div class="form-group">
                        <label>{{ t('adm_reports.record_limit') }}</label>
                        <select v-model="commentsReport.limit" class="input-field">
                            <option :value="25">25</option>
                            <option :value="50">50</option>
                            <option :value="100">100</option>
                            <option :value="250">250</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>{{ t('adm_reports.date_from') }}</label>
                        <input type="date" v-model="commentsReport.date_from" class="input-field" />
                    </div>

                    <div class="form-group">
                        <label>{{ t('adm_reports.date_to') }}</label>
                        <input type="date" v-model="commentsReport.date_to" class="input-field" />
                    </div>
                </div>

                <div class="report-actions">
                    <button type="button" class="btn-primary" @click="generateCommentsReport">
                        {{ t('adm_reports.generate_pdf') }}
                    </button>
                </div>
            </div>

            <!-- Popular Artists Report Card -->
            <div class="report-card">
                <div class="report-header">
                    <div>
                        <h3 class="report-title">{{ t('adm_reports.popular_artists_title') }}</h3>
                        <p class="report-description">{{ t('adm_reports.popular_artists_description') }}</p>
                    </div>
                </div>

                <div class="report-filters">
                    <div class="form-group">
                        <label>{{ t('adm_reports.artist_limit') }}</label>
                        <select v-model="popularArtistsReport.limit" class="input-field">
                            <option :value="25">25</option>
                            <option :value="50">50</option>
                            <option :value="100">100</option>
                            <option :value="250">250</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>{{ t('adm_reports.min_popularity') }}</label>
                        <input
                            type="number"
                            v-model="popularArtistsReport.min_popularity"
                            class="input-field"
                            step="0.1"
                            min="0"
                            :placeholder="t('adm_reports.min_popularity_placeholder')"
                        />
                    </div>

                    <div class="form-group">
                        <label>{{ t('adm_reports.activity_status') }}</label>
                        <select v-model="popularArtistsReport.activity_status" class="input-field">
                            <option value="all">{{ t('adm_reports.status_all') }}</option>
                            <option value="active">{{ t('adm_reports.status_active') }}</option>
                            <option value="inactive">{{ t('adm_reports.status_inactive') }}</option>
                        </select>
                    </div>
                </div>

                <div class="report-actions">
                    <button type="button" class="btn-primary" @click="generatePopularArtistsReport">
                        {{ t('adm_reports.generate_pdf') }}
                    </button>
                </div>
            </div>
        </div>
    </AdminLayout>
</template>

<style scoped>
.reports-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 1rem;
}

.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
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
    display: inline-block;
    border: none;
    cursor: pointer;
}

.btn-secondary:hover {
    background-color: #4b5563;
}

.report-card {
    background: white;
    border-radius: 0.75rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    padding: 1.5rem;
    margin-bottom: 2rem;
}

.report-header {
    margin-bottom: 1.5rem;
}

.report-title {
    font-size: 1.25rem;
    font-weight: 600;
    color: #1f2937;
    margin: 0 0 0.25rem 0;
}

.report-description {
    font-size: 0.875rem;
    color: #6b7280;
    margin: 0;
}

.report-filters {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 1.5rem;
}

.form-group {
    display: flex;
    flex-direction: column;
}

.form-group label {
    font-size: 0.875rem;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.25rem;
}

.input-field {
    width: 100%;
    padding: 0.5rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    transition: all 0.2s;
}

.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

/* make entire date input field clickable */
input[type="date"] {
    position: relative;
    cursor: pointer;
}

input[type="date"]::-webkit-calendar-picker-indicator {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 100%;
    color: transparent;
    background: transparent;
    cursor: pointer;
    opacity: 0;
}

.report-actions {
    display: flex;
    justify-content: flex-end;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    border: none;
    cursor: pointer;
    transition: background 0.2s;
}

.btn-primary:hover {
    background-color: #2563eb;
}

/* Responsive design */
@media (max-width: 768px) {
    .report-filters {
        grid-template-columns: 1fr;
    }
    .report-actions {
        justify-content: stretch;
    }
    .btn-primary {
        width: 100%;
        text-align: center;
    }
}

</style>
