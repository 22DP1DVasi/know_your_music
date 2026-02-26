<script setup>
import { ref, watch } from 'vue';
import { router } from '@inertiajs/vue3';
import { debounce } from 'lodash-es';

const props = defineProps({
    // sākotnējā meklēšanas vaicājuma vērtība
    modelValue: {
        type: String,
        default: ''
    },
    // vietturis
    placeholder: {
        type: String,
        default: 'Search...'
    },
    // meklēšanas ceļš
    searchRoute: {
        type: [String, Function],
        default: '/search'
    },
    // vaicājuma parametra nosaukums
    queryParam: {
        type: String,
        default: 'q'
    },
    // debounce, ms
    debounceTime: {
        type: Number,
        default: 0
    },
    // vai aktivizēt meklēšanu ievadē ar debounce vai tikai pogas klikšķī
    searchOnInput: {
        type: Boolean,
        default: false
    },
    // papildu vaicājuma parametri
    additionalParams: {
        type: Object,
        default: () => ({})
    },
    // kompaktais režīms
    compact: {
        type: Boolean,
        default: false
    }
});

const emit = defineEmits(['update:modelValue', 'search', 'input']);

const localSearchQuery = ref(props.modelValue);
const isSearching = ref(false);

watch(() => props.modelValue, (newValue) => {
    localSearchQuery.value = newValue;
});

watch(localSearchQuery, (newValue) => {
    emit('update:modelValue', newValue);
    emit('input', newValue);
});

const debouncedSearch = debounce(() => {
    performSearch();
}, props.debounceTime);

const handleInput = () => {
    if (props.searchOnInput) {
        if (props.debounceTime > 0) {
            debouncedSearch();
        } else {
            performSearch();
        }
    }
};

const handleSearch = () => {
    if (props.debounceTime > 0 && props.searchOnInput) {
        debouncedSearch.cancel();
    }
    performSearch();
};

const performSearch = () => {
    const query = localSearchQuery.value?.trim();
    if (!query) return;
    isSearching.value = true;

    // veidot parametru objektu
    const params = {
        [props.queryParam]: query,
        ...props.additionalParams
    };

    // noteikt maršrutu
    let route;
    if (typeof props.searchRoute === 'function') {
        route = props.searchRoute(params);
    } else {
        route = props.searchRoute;
    }

    // navigācija, izmantojot router'u
    router.get(route, params, {
        preserveState: true,
        preserveScroll: true,
        onFinish: () => {
            isSearching.value = false;
        }
    });

    emit('search', query);
};

// eksponēt/sniegt metodes vecākkomponentiem
defineExpose({
    search: performSearch,
    clear: () => {
        localSearchQuery.value = '';
    },
    focus: () => {
        // ievades elementam ir nepieciešama atsauce lai darbotos
    }
});

</script>

<template>
    <div class="search-container" :class="{ 'compact': compact }">
        <div class="search">
            <input
                type="search"
                autocomplete="off"
                class="searchTerm"
                :placeholder="placeholder"
                v-model="localSearchQuery"
                @keyup.enter="handleSearch"
                @input="handleInput"
            >
            <button
                type="submit"
                class="searchButton"
                @click="handleSearch"
                :disabled="isSearching"
            >
                <i class="fa fa-search"></i>
            </button>
        </div>
    </div>
</template>

<style scoped>
.search-container {
    width: 80%;
}

.search-container.compact {
    width: 100%;
}

@media (max-width: 1270px) {
    .search-container {
        margin-right: 30px;
    }

    .search-container.compact {
        margin-right: 0;
    }
}

.search {
    margin: 0 auto;
    width: 100%;
    position: relative;
    display: flex;
    z-index: 1;
}

@media (max-width: 1370px) {
    .search {
        width: 90%;
    }

    .search-container.compact .search {
        width: 100%;
    }
}

.searchTerm {
    width: 100%;
    border: 3px solid #54b3ebed;
    border-right: none;
    padding: 10px;
    height: 40px;
    border-radius: 7px 0 0 7px;
    outline: none;
    color: #000000;
    font-size: 16px;
    transition: border-color 0.3s ease;
}

.searchTerm:focus {
    outline: none !important;
    box-shadow: none !important;
    border-color: #3a9bd5;
}

.searchButton {
    position: relative;
    width: 40px;
    height: 40px;
    border: 1px solid #54b3ebed;
    background: #54b3ebed;
    text-align: center;
    color: #fff;
    border-radius: 0 7px 7px 0;
    cursor: pointer;
    font-size: 20px;
    overflow: hidden;
    transition: background-color 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.searchButton:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.searchButton:disabled:hover::after {
    display: none;
}

.searchButton i {
    transition: transform 0.3s ease, opacity 0.3s ease;
}

/* mainīt uz mūzikas ikonu, novietojot kursoru */
.searchButton:hover:not(:disabled) i {
    opacity: 0;
    transform: scale(0.5);
}

/* pievienot mūzikas ikonu pēc norādīšanas */
.searchButton:hover:not(:disabled)::after {
    content: "\f001";
    font-family: "FontAwesome";
    font-size: 20px;
    color: #fff;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(1);
    opacity: 1;
    transition: opacity 0.3s ease, transform 0.3s ease;
}

.searchButton::after {
    content: "";
    opacity: 0;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(0.5);
}

/* meobligāts ielādes stāvoklis */
.searchButton.searching i {
    animation: pulse 1s infinite;
}

@keyframes pulse {
    0%, 100% {
        opacity: 1;
    }
    50% {
        opacity: 0.5;
    }
}

/* Responsivitāte */
@media (max-width: 768px) {
    .search-container {
        width: 100%;
        margin-right: 0;
    }

    .search {
        width: 100%;
    }

    .searchTerm {
        height: 36px;
        font-size: 14px;
    }

    .searchButton {
        width: 36px;
        height: 36px;
        font-size: 18px;
    }
}

</style>
