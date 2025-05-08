<template>
    <section>
<!--    <div class="release-results">-->
<!--        <div-->
<!--            v-for="release in props.artist.releases"-->
<!--            :key="release.id"-->
<!--            class="release-card"-->
<!--            @click="redirectToRelease(release.slug)"-->
<!--        >-->
<!--            <div class="image-wrapper">-->
<!--                <img :src="release.cover_url" :alt="release.title">-->
<!--            </div>-->
<!--            <div class="release-info">-->
<!--                <h3>{{ release.title }}</h3>-->
<!--                <p class="release-year">{{ release.year }}</p>-->
<!--                <p class="release-type">{{ release.type }}</p>-->
<!--            </div>-->
<!--        </div>-->
<!--    </div>-->
    </section>

</template>

<style scoped>

.release-results {
    display: flex;
    flex-wrap: wrap;
    gap: 1.5rem;
    justify-content: flex-start;
}

.release-card {
    flex: 0 0 calc(25% - 1.125rem);
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15),
    0 3px 6px rgba(0, 0, 0, 0.1);
    cursor: pointer;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    display: flex;
    flex-direction: column;
}

.release-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 28px rgba(0, 0, 0, 0.2),
    0 8px 12px rgba(0, 0, 0, 0.15);
}

.image-wrapper {
    width: 100%;
    aspect-ratio: 1 / 1;
    background: #f8f8f8;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.image-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.release-info {
    padding: 1rem;
    overflow: hidden;
    width: 100%;
}

.release-info h3 {
    margin: 0 0 0.25rem 0;
    font-size: 1rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}

.release-year, .release-type {
    margin: 0 0 0.25rem 0;
    color: #666;
    font-size: 0.9rem;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

@media (max-width: 1024px) {
    .release-results {
        display: block;
        overflow-x: auto;
        white-space: nowrap;
        padding: 10px;
        margin: 0 -10px;
        scrollbar-width: thin;
        scrollbar-color: #0c4baa #f0f0f0;
    }

    .release-results::-webkit-scrollbar {
        height: 6px;
    }

    .release-results::-webkit-scrollbar-track {
        background: #f0f0f0;
    }

    .release-results::-webkit-scrollbar-thumb {
        background-color: #0c4baa;
        border-radius: 6px;
    }

    .release-card {
        display: inline-block;
        vertical-align: top;
        width: 250px;
        margin-right: 15px;
        flex: none;
    }
}

@media (max-width: 480px) {
    .release-results {
        justify-content: center;
    }

    .release-card {
        flex: 0 0 80%;
    }

    .release-info h3 {
        font-size: 0.95rem;
    }

    .release-year, .release-type {
        font-size: 0.85rem;
    }
}

</style>
