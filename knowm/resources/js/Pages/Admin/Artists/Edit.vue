<script setup>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link, useForm } from '@inertiajs/vue3';
import { route } from 'ziggy-js';
import { useI18n } from 'vue-i18n';
import { computed, watch } from 'vue';

const props = defineProps({
    artist: Object,
    soloOrBandOptions: Array
});

const form = useForm({
    name: props.artist.name,
    biography: props.artist.biography || '',
    biography_lv: props.artist.biography_lv || '',
    formed_year: props.artist.formed_year || '',
    disbanded_year: props.artist.disbanded_year || '',
    is_active: props.artist.is_active ? 1 : 0,
    solo_or_band: props.artist.solo_or_band || 'band',
});

const { t } = useI18n();

const submit = () => {
    form.put(route('admin-artists-update', { id: props.artist.id }));
};

const resetForm = () => {
    form.reset();
    form.name = props.artist.name;
    form.biography = props.artist.biography || '';
    form.biography_lv = props.artist.biography_lv || '';
    form.formed_year = props.artist.formed_year || '';
    form.disbanded_year = props.artist.disbanded_year || '';
    form.is_active = props.artist.is_active ? 1 : 0;
    form.solo_or_band = props.artist.solo_or_band || 'band';
};

// palīga (helper) funkcija ievades garuma ierobežošanai
const limitInput = (field, maxLength) => {
    if (form[field].length > maxLength) {
        form[field] = form[field].substring(0, maxLength);
    }
};

// skatīties vārda garuma ierobežojumu
watch(() => form.name, () => {
    limitInput('name', 255);
});

// ģenerēt gada opcijas nolaižamajiem sarakstiem (no 1900. gada līdz pašreizējam gadam + 10)
const currentYear = new Date().getFullYear();
const yearOptions = Array.from({ length: currentYear + 10 - 1900 + 1 },
    (_, i) => 1900 + i)
    .reverse();

const disbandedYearOptions = computed(() => {
    if (!form.formed_year) {
        return yearOptions;
    }

    return yearOptions.filter(
        year => year >= Number(form.formed_year)
    );
});

watch(() => form.formed_year, (newFormedYear) => {
    if (
        form.disbanded_year &&
        newFormedYear &&
        Number(form.disbanded_year) < Number(newFormedYear)
    ) {
        form.disbanded_year = '';
    }
});

// formatēt popularitāti priekš UI
const formattedPopularity = props.artist.popularity ?
    parseFloat(props.artist.popularity).toFixed(2) :
    '0.00';

</script>

<template>
    <AdminLayout>
        <div class="header-container">
            <h1>{{ t('adm_artists.edit.title') }}</h1>
            <div class="form-actions">
                <button
                    type="button"
                    @click="resetForm"
                    class="btn-secondary"
                >
                    {{ t('adm_artists.edit.reset_btn') }}
                </button>
                <button
                    type="submit"
                    class="btn-primary"
                    :disabled="form.processing"
                    @click="submit"
                >
                    {{ t('adm_artists.edit.update_artist_btn') }}
                </button>
            </div>
            <Link :href="route('admin-artists-index')" class="btn-secondary">
                {{ t('adm_artists.edit.back_to_artists') }}
            </Link>
        </div>

        <div class="form-container">
            <form @submit.prevent="submit">
                <div class="form-grid">
                    <!-- Izpildītāja vārds -->
                    <div class="form-group">
                        <label for="name">{{ t('adm_artists.edit.artist_name') }}</label>
                        <input
                            v-model="form.name"
                            id="name"
                            type="text"
                            maxlength="255"
                            class="input-field"
                            :class="{ 'input-error': form.errors.name }"
                            :placeholder="t('adm_artists.edit.artist_name_placeholder')"
                        >
                        <div v-if="form.errors.name" class="error-message">
                            {{ form.errors.name }}
                        </div>
                        <div class="character-count" :class="{ 'near-limit': form.name.length > 200 }">
                            {{ form.name.length }}/255 {{ t('adm_artists.edit.characters') }}
                        </div>
                    </div>

                    <!-- Tips -->
                    <div class="form-group">
                        <label for="solo_or_band">{{ t('adm_artists.edit.artist_type') }}</label>
                        <select
                            v-model="form.solo_or_band"
                            id="solo_or_band"
                            class="input-field"
                            :class="{ 'input-error': form.errors.solo_or_band }"
                        >
                            <option
                                v-for="option in soloOrBandOptions"
                                :key="option"
                                :value="option"
                            >
                                {{ t(`adm_artists.edit.type_${option}`) }}
                            </option>
                        </select>
                        <div v-if="form.errors.solo_or_band" class="error-message">
                            {{ form.errors.solo_or_band }}
                        </div>
                    </div>

                    <!-- Karjeras sākšanas gads -->
                    <div class="form-group">
                        <label for="formed_year">{{ t('adm_artists.edit.formed_year') }}</label>
                        <select
                            v-model="form.formed_year"
                            id="formed_year"
                            class="input-field"
                            :class="{ 'input-error': form.errors.formed_year }"
                        >
                            <option value="">{{ t('adm_artists.edit.select_year') }}</option>
                            <option v-for="year in yearOptions"
                                    :value="year"
                                    :key="`formed-${year}`">
                                {{ year }}
                            </option>
                        </select>
                        <div v-if="form.errors.formed_year" class="error-message">
                            {{ form.errors.formed_year }}
                        </div>
                    </div>

                    <!-- Karjeras beigu gads -->
                    <div class="form-group">
                        <label for="disbanded_year">{{ t('adm_artists.edit.disbanded_year') }}</label>
                        <select
                            v-model="form.disbanded_year"
                            id="disbanded_year"
                            class="input-field"
                            :class="{ 'input-error': form.errors.disbanded_year }"
                        >
                            <option value="">
                                {{ t('adm_artists.edit.select_year') }}
                            </option>
                            <option
                                v-for="year in disbandedYearOptions"
                                :key="`disbanded-${year}`"
                                :value="year"
                            >
                                {{ year }}
                            </option>
                        </select>
                        <div v-if="form.errors.disbanded_year" class="error-message">
                            {{ form.errors.disbanded_year }}
                        </div>
                        <div class="help-text" v-if="form.disbanded_year">
                            {{ t('adm_artists.edit.disbanded_note') }}
                        </div>
                    </div>

                    <!-- Aktivitātes statuss -->
                    <div class="form-group">
                        <label for="is_active">{{ t('adm_artists.edit.activity_status') }}</label>
                        <select
                            v-model="form.is_active"
                            id="is_active"
                            class="input-field"
                            :class="{ 'input-error': form.errors.is_active }"
                        >
                            <option :value="1">{{ t('adm_artists.edit.active') }}</option>
                            <option :value="0">{{ t('adm_artists.edit.inactive') }}</option>
                        </select>
                        <div v-if="form.errors.is_active" class="error-message">
                            {{ form.errors.is_active }}
                        </div>
                    </div>

                    <!-- Biogrāfija angļu valodā -->
                    <div class="form-group">
                        <label for="biography">{{ t('adm_artists.edit.biography_en') }}</label>
                        <textarea
                            v-model="form.biography"
                            id="biography"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.biography }"
                            :placeholder="t('adm_artists.edit.biography_placeholder')"
                            rows="6"
                        ></textarea>
                        <div v-if="form.errors.biography" class="error-message">
                            {{ form.errors.biography }}
                        </div>
                    </div>

                    <!-- Biogrāfija latviešu valodā -->
                    <div class="form-group">
                        <label for="biography_lv">{{ t('adm_artists.edit.biography_lv') }}</label>
                        <textarea
                            v-model="form.biography_lv"
                            id="biography_lv"
                            class="input-field textarea-field"
                            :class="{ 'input-error': form.errors.biography_lv }"
                            :placeholder="t('adm_artists.edit.biography_placeholder')"
                            rows="6"
                        ></textarea>
                        <div v-if="form.errors.biography_lv" class="error-message">
                            {{ form.errors.biography_lv }}
                        </div>
                    </div>

                    <!-- Informācija (tikai lasāma) -->
                    <div class="artist-info-section">
                        <h3 class="info-section-title">{{ t('adm_artists.edit.artist_info') }}</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.artist_id') }}:</span>
                                <span class="info-value">{{ artist.id }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.slug') }}:</span>
                                <span class="info-value">{{ artist.slug }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.popularity') }}:</span>
                                <span class="info-value popularity-value">{{ formattedPopularity }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.created_at') }}:</span>
                                <span class="info-value">{{ artist.created_at }}</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">{{ t('adm_artists.edit.updated_at') }}:</span>
                                <span class="info-value">{{ artist.updated_at }}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </AdminLayout>
</template>

<style scoped>
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.header-container h1 {
    font-size: 1.875rem;
    font-weight: bold;
    color: #1f2937;
    margin: 0;
}

.form-container {
    background-color: white;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    padding: 1.5rem;
}

.form-grid {
    display: grid;
    gap: 1.5rem;
}

.form-group {
    margin-bottom: 0;
}

.form-group label {
    display: block;
    font-weight: 500;
    color: #374151;
    margin-bottom: 0.375rem;
    font-size: 0.875rem;
}

.help-text {
    color: #6b7280;
    font-size: 0.75rem;
    margin-top: 0.25rem;
    font-style: italic;
}

.input-field {
    width: 100%;
    padding: 0.625rem 0.75rem;
    border: 1px solid #d1d5db;
    border-radius: 0.375rem;
    font-size: 0.875rem;
    color: #374151;
    background-color: white;
    transition: all 0.2s ease-in-out;
    box-sizing: border-box;
}

.textarea-field {
    resize: vertical;
    min-height: 120px;
    font-family: inherit;
    line-height: 1.5;
}

.input-field:focus {
    outline: none;
    border-color: #3b82f6;
    box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.input-field.input-error {
    border-color: #ef4444;
}

.input-field.input-error:focus {
    border-color: #ef4444;
    box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}

select.input-field {
    appearance: none;
    background-position: right 0.5rem center;
    background-repeat: no-repeat;
    background-size: 1.5em 1.5em;
    padding-right: 2.5rem;
}

.character-count {
    color: #6b7280;
    font-size: 0.75rem;
    text-align: right;
    margin-top: 0.25rem;
    transition: color 0.2s ease;
}

.character-count.near-limit {
    color: #f59e0b;
}

.character-count.at-limit {
    color: #ef4444;
    font-weight: 500;
}

.error-message {
    color: #ef4444;
    font-size: 0.75rem;
    margin-top: 0.25rem;
}

.btn-primary,
.btn-secondary {
    display: inline-block;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
    font-weight: 500;
    text-decoration: none;
    text-align: center;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    border: none;
    font-size: 0.875rem;
}

.btn-primary {
    background-color: #3b82f6;
    color: white;
}

.btn-primary:hover:not(:disabled) {
    background-color: #2563eb;
}

.btn-primary:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.btn-secondary {
    background-color: #6b7280;
    color: white;
}

.btn-secondary:hover {
    background-color: #4b5563;
}

.form-actions {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
}

.artist-info-section {
    background-color: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 0.375rem;
    padding: 1.5rem;
    margin-top: 1rem;
    grid-column: 1 / -1;
}

.info-section-title {
    font-size: 1.125rem;
    font-weight: 600;
    color: #1f2937;
    margin-bottom: 1rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #e5e7eb;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
}

.info-item {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.info-label {
    font-size: 0.875rem;
    color: #6b7280;
    font-weight: 500;
}

.info-value {
    font-size: 0.875rem;
    color: #374151;
    font-weight: 600;
}

.info-value.popularity-value {
    font-family: monospace;
    color: #059669;
    font-size: 1rem;
}

/* Responsivitāte */
@media (max-width: 768px) {
    .header-container {
        flex-direction: column;
        gap: 1rem;
        align-items: flex-start;
    }

    .header-container h1 {
        font-size: 1.5rem;
    }

    .form-container {
        padding: 1rem;
        margin: 0 -1rem;
        border-radius: 0;
    }

    .form-actions {
        flex-direction: column;
        width: 100%;
    }

    .form-actions button,
    .form-actions a {
        width: 100%;
        text-align: center;
    }

    .info-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 480px) {
    .header-container h1 {
        font-size: 1.25rem;
    }
}

</style>
