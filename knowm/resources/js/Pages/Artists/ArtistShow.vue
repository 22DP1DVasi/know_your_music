<script setup>
import { Head, Link, usePage } from '@inertiajs/vue3'
import { route } from 'ziggy-js'
import Navbar from '@/Components/Navbar.vue'
import AudioPlayer from '@/Components/MiniAudioPlayer.vue';
import Footer from '@/Components/Footer.vue'
import {ref, computed, nextTick, onMounted, onBeforeUnmount} from 'vue'
import ColorThief from 'colorthief'
import axios from 'axios'
import { useDate } from '@/composables/useDate'

const props = defineProps({
    artist: {
        type: Object,
        required: true,
        default: () => ({
            artist: Object,
            tracks: Array,
            total_tracks: Number,
            genres: Array,
            releases: Array,
            total_releases: Number,
        })
    }
});

// piekļuve koplietojamiem datiem no servera puses
const page = usePage();

const heroImage = ref(null);
const heroStyle = ref({
    height: '400px',
    position: 'relative',
    overflow: 'hidden',
    backgroundColor: '#f0f0f0'
});
const imageStyle = ref({
    opacity: 0,
    transition: 'opacity 0.3s ease',
    width: '100%',
    height: '100%',
    objectFit: 'cover'
});
const isLandscape = ref(false);
const colorThief = new ColorThief();
const bioMaxLength = 500;
const showPlayer = ref(false);
const currentAudioSource = ref('');

// attēlu apstrāde
const handleImageLoad = () => {
    const img = heroImage.value;
    if (!img) return;

    imageStyle.value.opacity = 1;
    analyzeImage();
};

const analyzeImage = () => {
    const img = heroImage.value;
    if (!img) return;
    heroStyle.value = {
        'height': '400px',
        'position': 'relative',
        'overflow': 'hidden',
        'background-color': '#f0f0f0' // atkāpšanās / fallback
    };
    imageStyle.value = {
        'opacity': '0',
        'transition': 'opacity 0.3s ease'
    };
    isLandscape.value = img.naturalWidth > img.naturalHeight;
    if (isLandscape.value) {
        Object.assign(heroStyle.value, {
            'height': '400px',
            'position': 'relative',
            'overflow': 'hidden'
        });
        Object.assign(imageStyle.value, {
            'width': '100%',
            'height': '100%',
            'object-fit': 'cover',
            'object-position': 'center 13%',
        });
    } else {
        try {
            const dominantColor = colorThief.getColor(img);
            const bgColor = `rgb(${dominantColor.join(',')})`;
            const darkerColor = dominantColor.map(c => Math.max(0, c - 30)).join(',');
            Object.assign(heroStyle.value, {
                '--gradient-color-left': `rgba(${darkerColor},0.8)`,
                '--gradient-color-right': `rgba(${darkerColor},0.8)`,
                'background-color': bgColor,
                'height': '400px',
                'position': 'relative',
                'display': 'flex',
                'justify-content': 'center',
                'align-items': 'center'
            });
            Object.assign(imageStyle.value, {
                'max-height': '100%',
                'max-width': '100%',
                'object-fit': 'contain',
                'position': 'relative',
                'z-index': '2'
            });
        } catch (e) {
            console.error('Error extracting color:', e);
            Object.assign(heroStyle.value, {
                '--gradient-color-left': 'rgba(0,0,0,0.3)',
                '--gradient-color-right': 'rgba(0,0,0,0.3)',
                'background-color': '#f0f0f0',
                'height': '400px',
                'position': 'relative'
            });
            Object.assign(imageStyle.value, {
                'max-height': '100%',
                'max-width': '100%',
                'object-fit': 'contain'
            });
        }
    }

    imageStyle.value.opacity = '1';
};

const truncatedBio = computed(() => {
    if (!props.artist.artist.biography) return 'There is no background for this artist.';
    if (props.artist.artist.biography.length <= bioMaxLength) return props.artist.artist.biography;
    return props.artist.artist.biography.substring(0, bioMaxLength) + '...';
});

const showReadMore = computed(() => {
    return props.artist.artist.biography && props.artist.artist.biography.length > bioMaxLength;
});

const playTrack = (source) => {
    currentAudioSource.value = source;
    showPlayer.value = true;
    setTimeout(() => {
        document.querySelector('.audio-player')?.scrollIntoView({ behavior: 'smooth' });
    }, 100);
};

const closePlayer = () => {
    showPlayer.value = false;
    currentAudioSource.value = '';
};

const redirectToFullBio = (slug) => {
    window.location.href = `/artists/${slug}/bio`;
};

const redirectToAllGenres = () => {
    window.location.href = '#';
};

const redirectToGenre = (slug) => {
    window.location.href = `/genres/${slug}`;
};

const redirectToAllTracks = (slug) => {
    window.location.href = `/artists/${slug}/tracks`;
};

const redirectToTrack = (slug) => {
    window.location.href = `/tracks/${slug}`;
};

const redirectToRelease = (slug) => {
    window.location.href = `/releases/${slug}`;
};

const redirectToAllReleases = (slug) => {
    window.location.href = `/artists/${slug}/releases`;
};
const capitalize = (value) => {
    if (!value) return 'Unknown';
    return value.charAt(0).toUpperCase() + value.slice(1).toLowerCase();
};

const formatDuration = (timeString) => {
    if (!timeString) return '--:--';
    const [hours, minutes, seconds] = timeString.split(':');
    return minutes.padStart(2, '0') + ':' + seconds.padStart(2, '0');
};

// komentāru reaktīvie rekvizīti
const comments = ref(props.artist.comments || []);
const commentsPagination = ref(props.artist.comments_pagination || {
    current_page: 1,
    last_page: 1,
    total: 0,
    per_page: 10
});
const loadingComments = ref(false);
const showLoadMore = computed(() => {
    return commentsPagination.value.current_page < commentsPagination.value.last_page;
});
const expandedComments = ref(new Set()); // izseko, kuri komentāri tiek izvērsti
const commentMaxLength = 400; // komentāru maksimālais garums saīsināšanai

const { formatDateLL, fromNow, diffInMinutes } = useDate();

const isAuthenticated = computed(() => !!page.props.auth?.user);
const currentUser = page.props.auth?.user;
const roles = computed(() => currentUser?.roles ?? [])
// const isCommentsModerator = computed(() => roles.value.includes('comments_moderator'))

const isCommentsModerator = computed(() => ['comments_moderator', 'super_admin']
    .some(role => roles.value.includes(role)));
const isAddingComment = ref(false);
const newCommentText = ref('');
const isSubmittingComment = ref(false);
const replyingToCommentId = ref(null);
const replyText = ref('');
const isSubmittingReply = ref(false);
const showAuthPopup = ref(false);
const authPopupCommentId = ref(null);
const activeCommentMenu = ref(null);
const showDeletePopup = ref(false);
const commentToDelete = ref(null);
const isDeletingComment = ref(false);
const editingCommentId = ref(null);
const editText = ref('');
const isSubmittingEdit = ref(false);

// automātiski maina textarea augstumu, lai iekļautu visu tekstu kamēr tas tiek rakstīts
const autoResizeTextarea = async (event) => {
    // gaidīt, līdz DOM atjauninās
    await nextTick();  // nextTick ļauj izpildīt kodu pēc tam, kad vietnē ir mainīti kādi dati
    const el = event.target;
    if (!el) return;
    el.style.height = 'auto';
    el.style.height = el.scrollHeight + 'px';
}

const loadMoreComments = async () => {
    if (loadingComments.value || !showLoadMore.value) return;
    loadingComments.value = true;
    const nextPage = commentsPagination.value.current_page + 1;
    try {
        const response = await axios.get(`/artists/${props.artist.artist.slug}/comments`, {
            params: { page: nextPage }
        });
        comments.value = [...comments.value, ...response.data.comments];
        commentsPagination.value = {
            ...commentsPagination.value,
            current_page: response.data.pagination.current_page,
            last_page: response.data.pagination.last_page
        };
    } catch (error) {
        console.error('Error loading comments:', error);
    } finally {
        loadingComments.value = false;
    }
};

// helper, lai rekursīvi atveidotu ligzdotos komentārus
const renderComment = (comment, depth = 0) => {
    // ierobežot dziļumu līdz 2 atkāpes līmeņiem
    const maxDepth = 2;
    const actualDepth = Math.min(depth, maxDepth);
    return {
        comment,
        depth: actualDepth,
        hasReplies: comment.replies && comment.replies.length > 0
    };
};

// saplacināt komentārus ar to atbildēm parādīšanai
const displayComments = computed(() => {
    const flattenComments = (commentList, depth = 0) => {
        let result = [];
        commentList.forEach(comment => {
            result.push(renderComment(comment, depth));
            if (comment.replies && comment.replies.length > 0) {
                // apstrādāt atbildes ar palielinātu dziļumu
                const replies = flattenComments(comment.replies, depth + 1);
                result = [...result, ...replies];
            }
        });
        return result;
    };
    return flattenComments(comments.value);
});

// pārbaudīt, vai komentārs ir jāsaīsina
const needsTruncation = (comment) => {
    if (!comment?.text) return false;
    // noņemt HTML tagus, lai saskaitītu tikai teksta rakstzīmes
    const plainText = comment.text.replace(/<[^>]*>/g, '');
    return plainText.length > commentMaxLength;
};

const getTruncatedText = (comment) => {
    if (!comment?.text) return '';
    // noņemt HTML tagus, lai saskaitītu tikai teksta rakstzīmes
    const plainText = comment.text.replace(/<[^>]*>/g, '');
    if (plainText.length <= commentMaxLength) return comment.text;

    let truncated = plainText.substring(0, commentMaxLength);
    // mēģināt saīsināt teikuma beigās
    const lastPeriod = truncated.lastIndexOf('.');
    const lastExclamation = truncated.lastIndexOf('!');
    const lastQuestion = truncated.lastIndexOf('?');
    const breakPoints = [lastPeriod, lastExclamation, lastQuestion].filter(pos => pos > 0);

    if (breakPoints.length > 0) {
        const lastBreak = Math.max(...breakPoints);
        if (lastBreak > commentMaxLength * 0.7) { // saīsināt tikai tad, ja tas nav pārāk tālu atpakaļ
            truncated = truncated.substring(0, lastBreak + 1);
        }
    } else {
        // saīsināt pēdējā atstarpē
        const lastSpace = truncated.lastIndexOf(' ');
        if (lastSpace > commentMaxLength * 0.8) {
            truncated = truncated.substring(0, lastSpace);
        }
    }
    return truncated.trim() + '...';
};

// iegūt pilnu tekstu ar HTML
const getFullText = (comment) => {
    return comment?.text || '';
};

// pārslēgt komentāru paplašināšanu
const toggleCommentExpansion = (commentId) => {
    if (expandedComments.value.has(commentId)) {
        expandedComments.value.delete(commentId);
    } else {
        expandedComments.value.add(commentId);
    }
};

const isCommentExpanded = (commentId) => {
    return expandedComments.value.has(commentId);
};

const getDisplayText = (comment) => {
    if (!comment?.id) return '';
    if (isCommentExpanded(comment.id) || !needsTruncation(comment)) {
        return getFullText(comment);
    } else {
        return getTruncatedText(comment);
    }
};

const startAddingComment = async () => {
    if (!isAuthenticated.value) return;
    isAddingComment.value = true;
    // gaidīt, līdz DOM atjauninās
    await nextTick();
    document.querySelector('.comment-textarea')?.focus();
};

const cancelAddingComment = () => {
    isAddingComment.value = false;
    newCommentText.value = '';
    isSubmittingComment.value = false;
};

const submitComment = async () => {
    if (!newCommentText.value.trim() || !isAuthenticated.value || isSubmittingComment.value) {
        return;
    }
    isSubmittingComment.value = true;
    try {
        const response = await axios.post(`/artists/${props.artist.artist.slug}/comments`, {
            text: newCommentText.value.trim(),
            artist_id: props.artist.artist.id,
            parent_id: null // null priekš vecākkomentāriem
        });
        // veidlapas atiestatīšana
        isAddingComment.value = false;
        newCommentText.value = '';
        // pievienot jaunu komentāru komentāru masīva sākumam
        const newComment = response.data.comment;
        comments.value = [newComment, ...comments.value];
        // atjaunināt lapdales skaitu
        commentsPagination.value.total += 1;
        // gaidīt, līdz DOM atjauninās
        await nextTick();
        const firstComment = document.querySelector('.comment-item:first-child');
        firstComment?.scrollIntoView({ behavior: 'smooth', block: 'nearest' })

    } catch (error) {
        console.error('Error submitting comment:', error);
        alert('Failed to submit comment. Please try again.');
    } finally {
        isSubmittingComment.value = false;
    }
};

// computed vērtība, lai pārbaudītu, vai ir jāiespējo komentāra poga
const canSubmitComment = computed(() => {
    return newCommentText.value.trim().length > 0 && !isSubmittingComment.value;
});

// metode, lai sākt atbildēt uz komentāru
const startAddingReply = async (commentId) => {
    if (!isAuthenticated.value) {
        authPopupCommentId.value = commentId;
        showAuthPopup.value = true;
        return;
    }
    replyingToCommentId.value = commentId;
    replyText.value = '';
    // gaidīt, līdz DOM atjauninās
    await nextTick();
    const textarea = document.querySelector(`.reply-textarea`);
    textarea?.focus();
    // papildu ritināšana
    const replyForm = document.querySelector(`.reply-form-${commentId}`);
    replyForm?.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
};

const cancelReply = () => {
    replyingToCommentId.value = null;
    replyText.value = '';
    isSubmittingReply.value = false;
};

const submitReply = async (parentCommentId) => {
    if (!replyText.value.trim() || !isAuthenticated.value || isSubmittingReply.value) {
        return;
    }
    isSubmittingReply.value = true;
    try {
        const response = await axios.post(`/artists/${props.artist.artist.slug}/comments`, {
            text: replyText.value.trim(),
            artist_id: props.artist.artist.id,
            parent_id: parentCommentId
        });
        // atrast vecākkomentāru un pievienojiet atbildi
        const addReplyToComment = (commentList, parentId, newReply) => {
            for (let comment of commentList) {
                if (comment.id === parentId) {
                    if (!comment.replies) {
                        comment.replies = [];
                    }
                    comment.replies.push(newReply); // pievieno atbildi pedējā pozicijā
                    return true;
                }
                if (comment.replies && comment.replies.length > 0) {
                    if (addReplyToComment(comment.replies, parentId, newReply)) {
                        return true;
                    }
                }
            }
            return false;
        };

        // pievienot atbildi atbilstošajam komentāram
        const newReply = response.data.comment;
        addReplyToComment(comments.value, parentCommentId, newReply);
        // atbildes veidlapas atiestatīšana
        replyingToCommentId.value = null;
        replyText.value = '';
        // atjaunināt komentāru skaitu
        commentsPagination.value.total += 1;
    } catch (error) {
        console.error('Error submitting reply:', error);
        alert('Failed to submit reply. Please try again.');
    } finally {
        isSubmittingReply.value = false;
    }
};

const closeAuthPopup = () => {
    showAuthPopup.value = false;
    authPopupCommentId.value = null;
};

// computed property, lai pārbaudītu, vai ir jāiespējo reply poga
const canSubmitReply = (commentId) => {
    return replyingToCommentId.value === commentId &&
        replyText.value.trim().length > 0 &&
        !isSubmittingReply.value;
};

// helper, lai atrastu komentāru pēc ID
const findCommentById = (commentList, commentId) => {
    for (let comment of commentList) {
        if (comment.id === commentId) return comment;
        if (comment.replies && comment.replies.length > 0) {
            const found = findCommentById(comment.replies, commentId);
            if (found) return found;
        }
    }
    return null;
};

// komentāru izvēlnes pārslēgšanas metode
const toggleCommentMenu = (commentId, event) => {
    if (event) {
        event.stopPropagation(); // novērst  event bubbling - vecākelementi nedrīkst būt aktivizēti
    }
    if (activeCommentMenu.value === commentId) {
        activeCommentMenu.value = null;
    } else {
        activeCommentMenu.value = commentId;
    }
};

const closeCommentMenu = () => {
    activeCommentMenu.value = null;
};

// metode, lai pārbaudītu, vai komentārs pieder pašreizējam lietotājam
const isUserComment = (comment) => {
    if (!isAuthenticated.value || !comment.user) return false;
    return comment.user.id === currentUser?.id;
};

const canSeeActionMenu = (comment) => {
    if (!isAuthenticated.value) return false;
    // Lietotājs var skatīt darbību izvēlni, ja:
    // 1. Tas ir viņu komentārs, vai
    // 2. Viņš ir komentāru regulētājs
    return isUserComment(comment) || isCommentsModerator.value;
};

const canEditComment = (comment) => {
    if (!isAuthenticated.value) return false;
    // lietotājs var rediģēt tikai savus komentārus
    return isUserComment(comment);
};

const canDeleteComment = (comment) => {
    if (!isAuthenticated.value) return false;
    // Lietotājs var dzēst komentāru, ja:
    // 1. Tas ir viņu komentārs, vai
    // 2. Viņš ir komentāru regulētājs
    return isUserComment(comment) || isCommentsModerator.value;
};

// helper metode dzēšanas pogas etiķetes un ikonas iegūšanai
const getDeleteButtonInfo = (comment) => {
    if (isCommentsModerator.value && !isUserComment(comment)) {
        return {
            label: 'Delete (Admin)',
            icon: 'fa-solid fa-shield',
            isAdmin: true
        };
    } else {
        return {
            label: 'Delete',
            icon: 'fa-regular fa-trash-can',
            isAdmin: false
        };
    }
};

const canBeHardDeleted = (comment) => {
    // vai komentārā nav atbilžu
    const hasReplies = comment.replies && comment.replies.length > 0;
    // vai komentārs nav atbilde
    const isReply = comment.parent_id !== null;
    return !hasReplies && !isReply;
};

// helper metode dzēšanas apstiprinājuma ziņojuma iegūšanai
const getDeleteConfirmationMessage = () => {
    if (!commentToDelete.value) return '';
    const isAdminDelete = commentToDelete.value.isAdminDelete;
    if (isAdminDelete) {
        if (canBeHardDeleted(commentToDelete.value)) {
            return 'This comment will be permanently deleted as an administrator action.';
        } else {
            return 'This comment will be deleted (admin action) but kept for thread continuity.';
        }
    } else {
        return 'Are you sure you want to delete this comment permanently?';
    }
};

// rediģēšanas darbības apstrādes metode
const handleEditComment = (comment) => {
    closeCommentMenu();
    console.log('Edit comment:', comment.id);
    // TODO: Implement edit functionality
    alert('Edit functionality will be implemented soon');
};

// dzēšanas darbības apstrādes metode
const handleDeleteComment = (comment) => {
    initiateDeleteComment(comment);
};

// aizvērt izvēlni, noklikšķinot ārpus elementa
const handleClickOutside = (event) => {
    if (!event.target.closest('.comment-menu-button') && !event.target.closest('.comment-dropdown-menu')) {
        closeCommentMenu();
    }
};

// iestatīt klikšķi ārpus klausītāja
onMounted(() => {
    document.addEventListener('click', handleClickOutside);
});

onBeforeUnmount(() => {
    document.removeEventListener('click', handleClickOutside);
});

// komentāra dzēšanas sākšanas metode
const initiateDeleteComment = (comment) => {
    closeCommentMenu();
    // uznirstošā loga papildinformācijas saglabāšana
    commentToDelete.value = {
        ...comment,     // izkliedes operators (spread operator) kopē visus esošos komentāru rekvizītus
        isAdminDelete: isCommentsModerator.value && !isUserComment(comment)  // Būla karodziņš dažādiem dzēšanas uznirstošā loga stiliem
    };
    showDeletePopup.value = true;
};

const cancelDelete = () => {
    showDeletePopup.value = false;
    commentToDelete.value = null;
    isDeletingComment.value = false;
};

const markCommentAsDeleted = (commentList, commentId, deletedAt) => {
    // meklē komentāru komentāru sarakstā
    for (let comment of commentList) {
        if (comment.id === commentId) {
            // atjauno statusu pēc dzēšanas, ievieto vietturi
            comment.deleted_at = deletedAt;
            comment.text = null;
            return true;
        }
        // tas pats atbildēm
        if (comment.replies?.length) {
            if (markCommentAsDeleted(comment.replies, commentId, deletedAt)) {
                return true;
            }
        }
    }
    return false;
};

// dzēš komentāru no saraksta, uzreiz atjauno lapā
const removeCommentFromTree = (commentList, commentId) => {
    const index = commentList.findIndex(c => c.id === commentId);
    if (index !== -1) {
        commentList.splice(index, 1);
        return true;
    }
    for (let comment of commentList) {
        if (comment.replies?.length) {
            if (removeCommentFromTree(comment.replies, commentId)) {
                return true;
            }
        }
    }
    return false;
};

// dzēšanas apstiprināšanas un izpildes metode
const confirmDeleteComment = async () => {
    if (!commentToDelete.value || isDeletingComment.value) return;
    isDeletingComment.value = true;
    try {
        const response = await axios.delete(
            `/artists/${props.artist.artist.slug}/comments/${commentToDelete.value.id}`
        );
        if (response.data.success) {
            const { delete_type, deleted_at } = response.data;
            // ja komentārs tika forceDeleted
            if (delete_type === 'hard') {
                // pilnībā noņemt komentāru
                removeCommentFromTree(comments.value, commentToDelete.value.id);
            } else {
                // ja softDelete -> vietturis
                markCommentAsDeleted(
                    comments.value,
                    commentToDelete.value.id,
                    deleted_at ?? new Date().toISOString()
                );
            }
        }
    } catch (error) {
        console.error('Error deleting comment:', error);
        if (error.response?.status === 403) {
            alert('You are not authorized to delete this comment.');
        } else {
            alert('Failed to delete comment. Please try again.');
        }
    } finally {
        showDeletePopup.value = false;
        commentToDelete.value = null;
        isDeletingComment.value = false;
    }
};

// metode, lai pārbaudītu, vai komentārs ir izdzēsts
const isCommentDeleted = (comment) => {
    return comment.deleted_at !== null && comment.deleted_at !== undefined;
};

// metode, kas iegūst parādāmo tekstu, kurā ņemti vērā dzēstie komentāri
const getDisplayTextConsideringDeletion = (comment) => {
    if (isCommentDeleted(comment)) {
        return '<em class="deleted-comment-text">This comment has been deleted.</em>';
    }
    return getDisplayText(comment);
};

// metode, lai pārbaudītu, vai komentārs ir jāsaīsina (apsverot dzēšanu)
const needsTruncationWithDeletion = (comment) => {
    if (isCommentDeleted(comment)) {
        return false;
    }
    return needsTruncation(comment);
};

</script>

<template>
    <Head :title="artist.artist.name" />
    <link rel="preload" :href="artist.artist.profile_url" as="image">
    <Navbar />
    <main class="artist-page flex-1">
        <div class="artist-hero" :style="heroStyle">
            <div class="hero-gradient" v-if="!isLandscape"></div>
            <div class="hero-image-container">
                <img
                    :src="artist.artist.profile_url"
                    :alt="artist.artist.name"
                    class="hero-image"
                    ref="heroImage"
                    @load="handleImageLoad"
                    :style="imageStyle"
                    loading="eager"
                >
            </div>
            <h1 class="artist-name">{{ artist.artist.name }}</h1>
        </div>

        <div class="artist-content">
            <div class="main-content">
                <section class="artist-description">
                    <h2 class="section-title">About</h2>
                    <div class="bio-text" v-html="truncatedBio"></div>
                    <button
                        v-if="showReadMore"
                        @click="redirectToFullBio(props.artist.artist.slug)"
                        class="read-more-button"
                    >
                        Read more
                    </button>
                </section>

                <div class="artist-side-info">
                    <div class="info-card">
                        <h3 class="info-title">Details</h3>
                        <div class="info-flex">
                            <div class="info-item">
                                <span class="info-value">
                                  <b>{{ capitalize(artist.artist.solo_or_band) || 'Unknown' }}</b>
                                </span>
                            </div>
                            <div class="info-item">
                                <span class="info-value"><b>Years Active:</b> {{ artist.artist.formed_year || 'Not specified' }} - {{ artist.artist.disbanded_year || (artist.artist.is_active ? 'present' : 'not specified') }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="info-card genres-card">
                        <div class="genres-header">
                            <h3 class="info-title">Genres</h3>
<!--                            <button-->
<!--                                v-if="artist.genres.length > 5"-->
<!--                                class="see-all-button"-->
<!--                                @click="redirectToAllGenres"-->
<!--                            >-->
<!--                                See all genres-->
<!--                            </button>-->
                        </div>
                        <div v-if="!artist.genres.length">No genres related to this artist.</div>
                        <div v-else class="genre-tags">
                            <button
                                v-for="(genre, index) in artist.genres.slice(0, 5)"
                                :key="genre"
                                class="genre-tag"
                                :title="genre.name.length > 16 ? genre.name : ''"
                                @click="redirectToGenre(genre.slug)"
                            >
                                {{ genre.name }}
                            </button>
                        </div>
                    </div>
                </div>

                <section class="artist-tracks">
                    <div class="tracks-header">
                        <h2 class="section-title">Tracks</h2>
                        <button
                            v-if="artist.total_tracks > artist.tracks.length"
                            class="see-all-button"
                            @click="redirectToAllTracks(props.artist.artist.slug)"
                        >
                            See all {{ artist.total_tracks }} tracks
                        </button>
                    </div>
                    <div v-if="!artist.tracks.length" style="margin-bottom: 2rem;">No tracks found from this artist.</div>
                    <div v-else class="track-list">
                        <div v-for="(track, index) in artist.tracks" :key="track.id" class="track-card">
                            <span class="track-number">{{ index + 1 }}</span>
                            <img :src="track.cover_url" class="track-image" :alt="track.title">
                            <div class="track-info">
                                <h3>
                                    <a @click="redirectToTrack(track.slug)" class="track-title">
                                        {{ track.title }}
                                    </a>
                                </h3>
                            </div>
                            <button
                                v-if="track.audio_source"
                                @click="playTrack(track.audio_source)"
                                class="play-button"
                            >
                                <i class="fa-regular fa-circle-play"></i>
                            </button>
                            <div class="track-duration">{{ formatDuration(track.duration) }}</div>
                        </div>
                    </div>
                </section>

                <section class="artist-releases">
                    <div class="releases-header">
                        <h2 class="section-title">Releases</h2>
                        <button
                            v-if="artist.total_releases > artist.releases.length"
                            class="see-all-button"
                            @click="redirectToAllReleases(props.artist.artist.slug)"
                        >
                            See all {{ artist.total_releases }} releases
                        </button>
                    </div>
                    <div v-if="!artist.releases.length">No releases found for this artist.</div>
                    <div v-else class="release-results">
                        <div
                            v-for="release in props.artist.releases"
                            :key="release.id"
                            class="release-card"
                            @click="redirectToRelease(release.slug)"
                        >
                            <div class="image-wrapper">
                                <img :src="release.cover_url" :alt="release.title">
                            </div>
                            <div class="release-info">
                                <h3>{{ release.title }}</h3>
                                <p class="release-year">{{ release.year }}</p>
                                <p class="release-type">{{ release.type }}</p>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="artist-comments">
                    <h2 class="section-title">Comments ({{ commentsPagination.total }})</h2>

                    <!-- Pievienot komentāru sadaļu -->
                    <div class="add-comment-section">
                        <!-- Ja lietotājs nav autentificēts -->
                        <div v-if="!isAuthenticated" class="auth-prompt">
                            <p class="auth-text">
                                <Link :href="route('login')" class="auth-link">
                                    Log in
                                </Link> or
                                <Link :href="route('signup')" class="auth-link">
                                    Sign up
                                </Link> to add a comment.
                            </p>
                        </div>

                        <!-- Ja lietotājs ir autentificēts, bet nav komentāru režīmā -->
                        <div
                            v-else-if="!isAddingComment"
                            class="add-comment-placeholder"
                            @click="startAddingComment"
                        >
                            <div class="placeholder-content">
                                <i class="fa-regular fa-comment"></i>
                                <span>Add a comment...</span>
                            </div>
                            <div class="placeholder-underline"></div>
                        </div>

                        <!-- Ja lietotājs ir komentāru režīmā -->
                        <div v-else class="comment-input-container">
                            <div class="comment-input-wrapper">
                                <textarea
                                    v-model="newCommentText"
                                    class="comment-textarea"
                                    placeholder="Add a comment..."
                                    rows="1"
                                    maxlength="2000"
                                    @input="autoResizeTextarea"
                                />
                                <div class="comment-char-count" :class="{ 'near-limit': newCommentText.length > 1800 }">
                                    {{ newCommentText.length }}/2000
                                </div>
                            </div>

                            <div class="comment-actions">
                                <button
                                    @click="cancelAddingComment"
                                    class="comment-action-button cancel-button"
                                    :disabled="isSubmittingComment"
                                >
                                    Cancel
                                </button>
                                <button
                                    @click="submitComment"
                                    class="comment-action-button submit-button"
                                    :disabled="!canSubmitComment"
                                    :class="{ 'loading': isSubmittingComment }"
                                >
                                    <span v-if="isSubmittingComment">
                                        <i class="fa-solid fa-spinner fa-spin"></i> Posting...
                                    </span>
                                    <span v-else>Comment</span>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Esošo komentāru sadaļa -->
                    <div class="comments-section">
                        <div v-if="displayComments.length === 0" class="no-comments">
                            <p>No comments yet. Be the first to comment!</p>
                        </div>

                        <div v-else class="comments-list">
                            <div
                                v-for="(commentData, index) in displayComments"
                                :key="commentData.comment.id"
                                :class="['comment-item', `depth-${commentData.depth}`]"
                                :style="{ marginLeft: `${commentData.depth * 40}px` }"
                            >
                                <div class="comment-header">
                                    <div class="comment-user">
                                        <i class="fa-regular fa-user"></i>
                                        <span class="user-name">{{ commentData.comment.user?.name || 'Anonymous' }}</span>
                                    </div>

                                    <div class="comment-header-right">
                                        <span class="comment-time"
                                              :title="formatDateLL(commentData.comment.created_at)">
                                            {{ fromNow(commentData.comment.created_at) }}
                                        </span>

                                        <!-- Rādīt izvēlnes pogu, ja lietotājs var redzēt darbību izvēlni un komentārs netiek izdzēsts -->
                                        <div v-if="!isCommentDeleted(commentData.comment) && canSeeActionMenu(commentData.comment)"
                                             class="comment-menu-container">
                                            <button
                                                class="comment-menu-button"
                                                @click="toggleCommentMenu(commentData.comment.id, $event)"
                                                :aria-expanded="activeCommentMenu === commentData.comment.id"
                                                :title="activeCommentMenu === commentData.comment.id ? 'Close menu' : 'Open menu'"
                                                :class="{ 'admin-menu': isCommentsModerator && !isUserComment(commentData.comment) }"
                                            >
                                                <i class="fa-solid fa-ellipsis-vertical"></i>
                                            </button>

                                            <!-- Nolaižamā Izvēlne -->
                                            <div
                                                v-if="activeCommentMenu === commentData.comment.id"
                                                class="comment-dropdown-menu"
                                                @click.stop=""
                                                :class="{ 'admin-dropdown': isCommentsModerator && !isUserComment(commentData.comment) }"
                                            >
                                                <!-- Poga Rediģēt — rādīt tikai lietotāja paša komentāriem -->
                                                <button
                                                    v-if="canEditComment(commentData.comment)"
                                                    class="dropdown-item edit-item"
                                                    @click="handleEditComment(commentData.comment)"
                                                >
                                                    <i class="fa-regular fa-pen-to-square"></i>
                                                    <span>Edit</span>
                                                </button>

                                                <!-- Poga Dzēst - rādīt visiem komentāriem, kurus lietotājs var dzēst -->
                                                <button
                                                    v-if="canDeleteComment(commentData.comment)"
                                                    class="dropdown-item delete-item"
                                                    :class="{ 'admin-delete': isCommentsModerator && !isUserComment(commentData.comment) }"
                                                    @click="handleDeleteComment(commentData.comment)"
                                                >
                                                    <i :class="getDeleteButtonInfo(commentData.comment).icon"></i>
                                                    <span>{{ getDeleteButtonInfo(commentData.comment).label }}</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div
                                    :class="['comment-text', {
                                        'truncated': !isCommentExpanded(commentData.comment.id) && needsTruncationWithDeletion(commentData.comment),
                                        'deleted-comment': isCommentDeleted(commentData.comment)
                                    }]"
                                    v-html="getDisplayTextConsideringDeletion(commentData.comment)"
                                ></div>

                                <!-- Poga Lasīt vairāk/mazāk -->
                                <button
                                    v-if="!isCommentDeleted(commentData.comment) && needsTruncationWithDeletion(commentData.comment)"
                                    @click="toggleCommentExpansion(commentData.comment.id)"
                                    class="read-more-less-button"
                                >
                                    {{ isCommentExpanded(commentData.comment.id) ? 'Read less' : 'Read more' }}
                                </button>

                                <!-- Reply poga -->
                                <button
                                    v-if="!isCommentDeleted(commentData.comment)"
                                    @click="startAddingReply(commentData.comment.id)"
                                    class="reply-button"
                                >
                                    <i class="fa-regular fa-comment-dots"></i> Reply
                                </button>

                                <!-- Atbildes veidlapa (rādīt tikai atbildot uz šo komentāru) -->
                                <div
                                    v-if="!isCommentDeleted(commentData.comment) && replyingToCommentId === commentData.comment.id"
                                    :class="['reply-form', `reply-form-${commentData.comment.id}`]"
                                >
                                    <div class="reply-input-wrapper">
                                        <textarea
                                            v-model="replyText"
                                            class="reply-textarea"
                                            placeholder="Write a reply..."
                                            rows="2"
                                            maxlength="2000"
                                            @input="autoResizeTextarea"
                                        />
                                        <div class="reply-char-count" :class="{ 'near-limit': replyText.length > 1800 }">
                                            {{ replyText.length }}/2000
                                        </div>
                                    </div>

                                    <div class="reply-actions">
                                        <button
                                            @click="cancelReply"
                                            class="reply-action-button cancel-reply-button"
                                            :disabled="isSubmittingReply"
                                        >
                                            Cancel
                                        </button>
                                        <button
                                            @click="submitReply(commentData.comment.id)"
                                            class="reply-action-button submit-reply-button"
                                            :disabled="!canSubmitReply(commentData.comment.id)"
                                            :class="{ 'loading': isSubmittingReply }"
                                        >
                                            <span v-if="isSubmittingReply">
                                                <i class="fa-solid fa-spinner fa-spin"></i> Replying...
                                            </span>
                                            <span v-else>Reply</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Poga Ielādēt vairāk -->
                        <div v-if="showLoadMore" class="load-more-container">
                            <button
                                @click="loadMoreComments"
                                :disabled="loadingComments"
                                class="load-more-button"
                            >
                                <span v-if="loadingComments">Loading...</span>
                                <span v-else>Show more comments</span>
                            </button>
                        </div>
                    </div>
                </section>
            </div>

            <div class="sidebar-space">
                <!-- Future content like "Similar Artists" will go here -->
            </div>
        </div>
        <AudioPlayer
            :source="currentAudioSource"
            :show="showPlayer"
            @close="closePlayer"
        />
    </main>
    <Footer />

    <!-- Autentifikācijas uznirstošais logs -->
    <div v-if="showAuthPopup" class="auth-popup-overlay" @click="closeAuthPopup">
        <div class="auth-popup" @click.stop>
            <div class="auth-popup-header">
                <h3>Sign in to reply</h3>
                <button @click="closeAuthPopup" class="close-popup-button">
                    <i class="fa-solid fa-times"></i>
                </button>
            </div>
            <div class="auth-popup-content">
                <p>You need to be signed in to reply to comments.</p>
                <div class="auth-popup-actions">
                    <Link :href="route('login')" class="auth-popup-button login-button">
                        <i class="fa-solid fa-right-to-bracket"></i> Log in
                    </Link>
                    <Link :href="route('signup')" class="auth-popup-button signup-button">
                        <i class="fa-solid fa-user-plus"></i> Sign up
                    </Link>
                </div>
            </div>
        </div>
    </div>

    <!-- Dzēšanas apstiprinājuma uznirstošā izvēlne -->
    <div v-if="showDeletePopup" class="delete-popup-overlay" @click="cancelDelete">
        <div class="delete-popup" @click.stop>
            <div class="delete-popup-header" :class="{ 'admin-header': commentToDelete?.isAdminDelete }">
                <h3>
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    {{ commentToDelete?.isAdminDelete ? 'Admin: Delete Comment' : 'Delete Comment' }}
                    <span v-if="commentToDelete?.isAdminDelete" class="admin-badge">
                    <i class="fa-solid fa-shield"></i> Admin Action
                </span>
                </h3>
                <button @click="cancelDelete" class="close-popup-button">
                    <i class="fa-solid fa-times"></i>
                </button>
            </div>
            <div class="delete-popup-content">
                <p>{{ getDeleteConfirmationMessage() }}</p>

                <!-- Rādīt komentāru priekšskatījumu, ja tas vēl nav izdzēsts -->
                <div v-if="commentToDelete && !isCommentDeleted(commentToDelete)" class="comment-preview">
                    <div class="preview-header">
                        <strong>{{ commentToDelete.user?.name || 'Anonymous' }}</strong>
                    </div>
                    <div class="preview-text">
                        {{ commentToDelete.text ? (commentToDelete.text.substring(0, 150) + (commentToDelete.text.length > 150 ? '...' : '')) : '' }}
                    </div>
                </div>
            </div>
            <div class="delete-popup-actions">
                <button
                    @click="cancelDelete"
                    class="delete-popup-button cancel-delete-button"
                    :disabled="isDeletingComment"
                >
                    Cancel
                </button>
                <button
                    @click="confirmDeleteComment"
                    class="delete-popup-button confirm-delete-button"
                    :disabled="isDeletingComment"
                    :class="{
                    'loading': isDeletingComment,
                    'hard-delete': canBeHardDeleted(commentToDelete),
                    'admin-delete': commentToDelete?.isAdminDelete
                }"
                >
                <span v-if="isDeletingComment">
                    <i class="fa-solid fa-spinner fa-spin"></i> Deleting...
                </span>
                    <span v-else>
                    <i :class="commentToDelete?.isAdminDelete ? 'fa-solid fa-shield' : 'fa-solid fa-trash-can'"></i>
                    {{ commentToDelete?.isAdminDelete ? 'Delete as Admin' : (canBeHardDeleted(commentToDelete) ? 'Delete Permanently' : 'Delete') }}
                </span>
                </button>
            </div>
        </div>
    </div>
</template>

<style scoped>
.artist-page {
    max-width: 90%;
    width: 80%;
    margin: 0 auto 0;
    padding: 0 20px;
    border: 1px solid #ddd;
    border-bottom-style: none;
    background: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.artist-hero {
    height: 400px;
    width: 100%;
    overflow: hidden;
    position: relative;
    margin-bottom: 1rem;
    margin-top: 1rem;
    border-radius: 8px;
    background-color: #f0f0f0; /* atkāpšanās krāsa */
    --gradient-color-left: rgba(0,0,0,0.3);
    --gradient-color-right: rgba(0,0,0,0.3);
}

.hero-image-container {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: inherit;
}

.hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}

.hero-gradient {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
        90deg,
        var(--gradient-color-left) 0%,
        transparent 20%,
        transparent 80%,
        var(--gradient-color-right) 100%
    );
    z-index: 1;
}

.artist-name {
    position: absolute;
    bottom: 0;
    left: 0;
    padding: 1.5rem;
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow:
        -1px -1px 0 rgba(0, 0, 0, 0.9),
        1px -1px 0 rgba(0, 0, 0, 0.9),
        -1px  1px 0 rgba(0, 0, 0, 0.9),
        1px  1px 0 rgba(0, 0, 0, 0.9),
        -2px  0px 0 rgba(0, 0, 0, 0.7),
        2px  0px 0 rgba(0, 0, 0, 0.7),
        0px -2px 0 rgba(0, 0, 0, 0.7),
        0px  2px 0 rgba(0, 0, 0, 0.7);
    z-index: 3;
}

.artist-content {
    display: flex;
    gap: 40px;
    margin-top: 0.5rem;
}

.main-content {
    flex: 1;
    max-width: 70%;
}

.sidebar-space {
    width: 300px;
    flex-shrink: 0;
}

.see-all-button {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1rem;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    margin-bottom: 1rem;
    border-radius: 4px;
    transition: background 0.2s;
    white-space: nowrap;
    flex-shrink: 0;
}

.see-all-button:hover {
    background: rgba(12, 75, 170, 0.1);
}

.section-title {
    font-size: 1.5rem;
    margin-bottom: 1rem;
    color: #0c4baa;
}

.artist-description {
    margin-bottom: 1.7rem;
}

.read-more-button {
    background: #0c4baa;
    color: white;
    border: none;
    padding: 0.5rem 1rem;
    border-radius: 4px;
    margin-top: 1rem;
    cursor: pointer;
    transition: background 0.2s;
}

.read-more-button:hover {
    background: #1a5fc9;
}

.bio-text {
    font-size: 0.9rem;
    line-height: 1.6;
}

.artist-side-info {
    display: flex;
    gap: 1.5rem;
    margin-bottom: 2.5rem;
    flex-wrap: wrap;
}

.info-card {
    background: white;
    border-radius: 8px;
    padding: 1.25rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    flex: 1;
    min-width: 200px;
    max-width: 300px;
}

.info-title {
    font-size: 1.1rem;
    margin-bottom: 1rem;
    color: #333;
}

.info-flex {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    flex-direction: column;
}

.info-item {
    flex: 1 0 calc(50% - 0.75rem);
    min-width: 120px;
    display: flex;
    flex-direction: row;
}

.info-value {
    font-weight: 500;
}

.genres-card {
    min-width: 300px;
    max-width: 350px;
}

.genres-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.genres-header .info-title {
    margin: 0;
    font-size: 1.1rem;
    flex-shrink: 1;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.genre-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.genre-tag {
    background: #f0f4ff;
    color: #0c4baa;
    padding: 0.35rem 0.75rem;
    border-radius: 20px;
    font-size: 0.85rem;
    max-width: 120px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    display: inline-block;
    vertical-align: middle;
    flex-shrink: 0;
    transition: background 0.2s;
}

.genre-tag:hover {
    background: #e0e8ff;
}

.tracks-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

.track-list {
    background: white;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
    max-width: 100%;
}

.track-card {
    display: flex;
    align-items: center;
    padding: 0.75rem 1rem;
    border-bottom: 1px solid #eee;
    gap: 0.75rem;
}

.track-number {
    color: #666;
    width: 24px;
    text-align: center;
    font-size: 0.9rem;
}

.track-image {
    width: 50px;
    height: 50px;
    border-radius: 4px;
    object-fit: cover;
    flex-shrink: 0;
}

.track-info {
    flex: 1;
    min-width: 0;
}

.track-info h3 {
    text-decoration: none;
    transition: color 0.2s;
    font-size: 0.95rem;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.track-title {
    cursor: pointer;
}

.track-title:hover {
    color: #0c4baa;
    text-decoration: underline;
}

.play-button {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 1.2rem;
    cursor: pointer;
    padding: 0 0.5rem;
    transition: transform 0.2s, color 0.2s;
    flex-shrink: 0;
}

.play-button:hover {
    color: #1a5fc9;
    transform: scale(1.1);
}

.track-duration {
    color: #666;
    font-size: 0.9rem;
    flex: 0 0 50px;
    text-align: right;
}

.artist-releases {
    margin-bottom: 3rem;
}

.releases-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    flex-wrap: nowrap;
    width: 100%;
}

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

.artist-comments {
    margin-bottom: 3rem;
}

/* komentāri */
.add-comment-section {
    margin-bottom: 2rem;
    background: white;
    border-radius: 8px;
    padding: 1rem 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    border: 1px solid #eaeaea;
}

.auth-prompt {
    padding: 0.75rem 0;
    color: #666;
    font-size: 0.95rem;
}

.auth-text {
    text-align: center;
}

.auth-link {
    color: #0c4baa;
    text-decoration: none;
    font-weight: 500;
    transition: color 0.2s;
}

.auth-link:hover {
    color: #1a5fc9;
    text-decoration: underline;
}

.add-comment-placeholder {
    cursor: pointer;
    padding: 0.5rem 0;
    transition: all 0.2s ease;
}

.add-comment-placeholder:hover {
    opacity: 0.8;
}

.placeholder-content {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    color: #666;
    font-size: 1rem;
    padding-bottom: 0.5rem;
}

.placeholder-content i {
    font-size: 1.1rem;
    color: #888;
}

.placeholder-underline {
    height: 2px;
    background: linear-gradient(90deg, #0c4baa 0%, transparent 100%);
    width: 100%;
    transition: all 0.3s ease;
}

.add-comment-placeholder:hover .placeholder-underline {
    background: linear-gradient(90deg, #1a5fc9 0%, transparent 100%);
}

/* komentāru ievades konteiners */
.comment-input-container {
    animation: slideDown 0.3s ease;
}

@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.comment-input-wrapper {
    position: relative;
    margin-bottom: 1rem;
}

.comment-textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-family: inherit;
    font-size: 0.95rem;
    line-height: 1.5;
    resize: none;
    overflow-y: hidden;
    min-height: 80px;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.comment-textarea:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 3px rgba(12, 75, 170, 0.1);
}

.comment-textarea::placeholder {
    color: #999;
}

.comment-char-count {
    position: absolute;
    bottom: 0.5rem;
    right: 0.75rem;
    font-size: 0.8rem;
    color: #999;
    background: white;
    padding: 0 0.25rem;
    transition: color 0.2s;
}

.comment-char-count.near-limit {
    color: #ff6b6b;
    font-weight: 500;
}

.comment-actions {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.comment-action-button {
    padding: 0.5rem 1.25rem;
    border-radius: 4px;
    font-size: 0.95rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    min-width: 90px;
    text-align: center;
}

.cancel-button {
    background: #f5f5f5;
    color: #666;
    border: 1px solid #ddd;
}

.cancel-button:hover:not(:disabled) {
    background: #eaeaea;
    color: #333;
}

.cancel-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.submit-button {
    background: #0c4baa;
    color: white;
    border: 1px solid #0c4baa;
}

.submit-button:hover:not(:disabled) {
    background: #1a5fc9;
    border-color: #1a5fc9;
}

.submit-button:disabled {
    background: #ccc;
    border-color: #ccc;
    cursor: not-allowed;
    color: #999;
}

.submit-button.loading {
    background: #0c4baa;
    border-color: #0c4baa;
    opacity: 0.8;
}

.submit-button.loading i {
    margin-right: 0.5rem;
}

.comments-section {
    background: white;
    border-radius: 8px;
    padding: 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 3rem;
}

.no-comments {
    text-align: center;
    padding: 2rem;
    color: #666;
    font-style: italic;
}

.comments-list {
    margin-bottom: 1.5rem;
}

.comment-item {
    border-bottom: 1px solid #eee;
    padding: 1rem 1rem;
    transition: background-color 0.2s;
    max-width: 100%;
    overflow-wrap: break-word;
    word-wrap: break-word;
    word-break: break-word;
}

.comment-item:last-child {
    border-bottom: none;
}

.comment-item:hover {
    background-color: #f9f9f9;
}

/* komentāru dziļuma indikatori */
.comment-item.depth-1 {
    border-left: 3px solid #e0e8ff;
    padding-left: 1rem;
    margin-left: 40px;
}

.comment-item.depth-2 {
    border-left: 3px solid #c9d7ff;
    padding-left: 1rem;
    margin-left: 80px;
}

.comment-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.comment-user {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.comment-user i {
    color: #0c4baa;
    font-size: 1.1rem;
}

.user-name {
    font-weight: 600;
    color: #333;
}

.comment-header-right {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.comment-time {
    font-size: 0.85rem;
    color: #666;
}

.comment-menu-container {
    position: relative;
}

.comment-menu-button {
    background: none;
    border: none;
    color: #666;
    font-size: 1rem;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    transition: all 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 32px;
    height: 32px;
}

.comment-menu-button:hover {
    background: #f0f0f0;
    color: #333;
}

.comment-menu-button[aria-expanded="true"] {
    background: #f0f4ff;
    color: #0c4baa;
}

/* administratoram raksturīgie darbību izvēlnes stili */
.comment-menu-button.admin-menu {
    color: #4a5568;
    background: #f7fafc;
    border: 1px solid #e2e8f0;
}

.comment-menu-button.admin-menu:hover {
    background: #edf2f7;
    border-color: #cbd5e0;
}

.comment-dropdown-menu.admin-dropdown {
    border: 1px solid #4299e1;
    box-shadow: 0 2px 10px rgba(66, 153, 225, 0.15);
}

.comment-dropdown-menu.admin-dropdown::before {
    border-bottom-color: #4299e1;
}

.dropdown-item.admin-delete {
    color: #3182ce;
}

.dropdown-item.admin-delete:hover {
    background: #ebf8ff;
    color: #2c5282;
}

.dropdown-item.admin-delete i {
    color: #4299e1;
}

/* administratora dzēšanas uznirstošā loga stili */
.delete-popup-header.admin-header {
    background: #ebf8ff;
    border-bottom: 2px solid #4299e1;
}

.admin-badge {
    background: #4299e1;
    color: white;
    font-size: 0.7rem;
    padding: 0.2rem 0.5rem;
    border-radius: 12px;
    margin-left: 0.75rem;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
}

.admin-badge i {
    font-size: 0.6rem;
}

.comment-dropdown-menu {
    position: absolute;
    top: 100%;
    right: 0;
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    min-width: 140px;
    z-index: 1000;
    margin-top: 0.25rem;
    overflow: hidden;
    animation: fadeIn 0.2s ease;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-5px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.dropdown-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    width: 100%;
    padding: 0.75rem 1rem;
    background: none;
    border: none;
    text-align: left;
    font-size: 0.9rem;
    cursor: pointer;
    transition: background-color 0.2s;
    border-bottom: 1px solid #f5f5f5;
}

.dropdown-item:last-child {
    border-bottom: none;
}

.dropdown-item:hover {
    background-color: #f8f9fa;
}

.dropdown-item.edit-item {
    color: #0c4baa;
}

.dropdown-item.edit-item:hover {
    background-color: #f0f4ff;
}

.dropdown-item.delete-item {
    color: #dc3545;
}

.dropdown-item.delete-item:hover {
    background-color: #fff5f5;
}

.dropdown-item i {
    font-size: 0.9rem;
    width: 16px;
    text-align: center;
}

/* komentāru laika atstarpju pielāgošana, ja ir pieejama izvēlne */
.comment-header-right .comment-time {
    margin-right: 0;
}

.comment-text {
    font-size: 0.95rem;
    line-height: 1.5;
    color: #333;
    margin-bottom: 0.5rem;
    white-space: pre-wrap;
    overflow-wrap: break-word;
    word-wrap: break-word;
    word-break: break-word;
}

.comment-text p {
    margin: 0.5rem 0;
}

.comment-text p:first-child {
    margin-top: 0;
}

.comment-text p:last-child {
    margin-bottom: 0;
}

/* saīsināta teksta izbalēšanas efekts */
.comment-text.truncated {
    position: relative;
    max-height: 6em;   /* Aptuveni 4 teksta rindiņas */
    overflow: hidden;
}

.comment-text.truncated::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 20px;
    background: linear-gradient(to bottom, transparent, white);
    pointer-events: none;
}

.comment-text:not(.truncated) {
    max-height: none;
}

/* Noņemt izbalēšanu izvēršanas laikā */
.comment-text:not(.truncated)::after {
    display: none;
}

.read-more-less-button {
    background: none;
    border: none;
    color: rgba(12, 75, 170, 0.7);
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    padding: 0.25rem 0;
    margin: 0.25rem 0 0.5rem 0;
    transition: color 0.2s;
    text-decoration: none;
    display: inline-block;
}

.read-more-less-button:hover {
    color: rgba(12, 75, 170, 1);
}

.comment-item.depth-1 .comment-header-right,
.comment-item.depth-2 .comment-header-right {
    flex-wrap: nowrap;
}

/* pārliecināties, vai komentāriem ar dziļumu ir pareizas atstarpes pogai */
.comment-item.depth-1 .read-more-less-button,
.comment-item.depth-2 .read-more-less-button {
    margin-left: 1rem;
}

/* pārliecināties, vai poga nepārmanto stilus no vecākelementa */
.read-more-less-button:focus {
    outline: none;
}

.load-more-container {
    text-align: center;
    padding-top: 1rem;
    border-top: 1px solid #eee;
}

.load-more-button {
    background: #0c4baa;
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 4px;
    font-size: 1rem;
    cursor: pointer;
    transition: background 0.2s;
    min-width: 180px;
}

.load-more-button:hover:not(:disabled) {
    background: #1a5fc9;
}

.load-more-button:disabled {
    background: #ccc;
    cursor: not-allowed;
}

/* Reply pogas stili */
.reply-button {
    background: none;
    border: none;
    color: #0c4baa;
    font-size: 0.85rem;
    font-weight: 500;
    cursor: pointer;
    padding: 0.25rem 0.75rem;
    border-radius: 4px;
    margin-top: 0.25rem;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    gap: 0.375rem;
}

.reply-button:hover {
    background: rgba(12, 75, 170, 0.08);
    color: #1a5fc9;
}

.reply-button i {
    font-size: 0.9rem;
}

/* nodrošināt atbilstošu atstarpi atbildes pogai ligzdotajos komentāros */
.comment-item.depth-1 .reply-button,
.comment-item.depth-2 .reply-button {
    margin-left: 1rem;
}

/* Reply veidlapas stili */
.reply-form {
    margin-top: 1rem;
    margin-left: 1rem;
    padding: 0.75rem;
    background: #f8faff;
    border-radius: 6px;
    border: 1px solid #e0e8ff;
    animation: slideDown 0.3s ease;
}

.reply-input-wrapper {
    position: relative;
    margin-bottom: 0.75rem;
}

.reply-textarea {
    width: 100%;
    padding: 0.625rem;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-family: inherit;
    font-size: 0.9rem;
    line-height: 1.4;
    resize: none;
    overflow-y: hidden;
    min-height: 60px;
    max-height: 400px;
    transition: border-color 0.2s, box-shadow 0.2s;
    background: white;
}

.reply-textarea::after {
    content: '';
    display: table;
    clear: both;
}

.reply-textarea:focus {
    outline: none;
    border-color: #0c4baa;
    box-shadow: 0 0 0 2px rgba(12, 75, 170, 0.1);
}

.reply-textarea::placeholder {
    color: #999;
}

.reply-char-count {
    position: absolute;
    bottom: 0.375rem;
    right: 0.625rem;
    font-size: 0.75rem;
    color: #999;
    background: white;
    padding: 0 0.25rem;
    transition: color 0.2s;
}

.reply-char-count.near-limit {
    color: #ff6b6b;
    font-weight: 500;
}

.reply-actions {
    display: flex;
    justify-content: flex-end;
    gap: 0.625rem;
}

.reply-action-button {
    padding: 0.375rem 1rem;
    border-radius: 4px;
    font-size: 0.875rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    border: none;
    min-width: 70px;
    text-align: center;
}

.cancel-reply-button {
    background: #f5f5f5;
    color: #666;
    border: 1px solid #ddd;
}

.cancel-reply-button:hover:not(:disabled) {
    background: #eaeaea;
    color: #333;
}

.cancel-reply-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.submit-reply-button {
    background: #0c4baa;
    color: white;
    border: 1px solid #0c4baa;
}

.submit-reply-button:hover:not(:disabled) {
    background: #1a5fc9;
    border-color: #1a5fc9;
}

.submit-reply-button:disabled {
    background: #ccc;
    border-color: #ccc;
    cursor: not-allowed;
    color: #999;
}

.submit-reply-button.loading {
    background: #0c4baa;
    border-color: #0c4baa;
    opacity: 0.8;
}

.submit-reply-button.loading i {
    margin-right: 0.375rem;
}

/* Izdzēsto komentāru stili */
.deleted-comment-text {
    color: #6c757d;
    font-style: italic;
    opacity: 0.8;
}

.comment-text.deleted-comment {
    color: #6c757d;
    font-style: italic;
    opacity: 0.8;
}

/* Dzēstā apstiprinājuma uznirstošā loga stili */
.delete-popup-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    animation: fadeIn 0.2s ease;
}

.delete-popup {
    background: white;
    border-radius: 12px;
    width: 90%;
    max-width: 500px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
    animation: slideUp 0.3s ease;
    overflow: hidden;
}

.delete-popup-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.25rem 1.5rem;
    border-bottom: 1px solid #e9ecef;
    background: #fff5f5;
}

.delete-popup-header h3 {
    margin: 0;
    font-size: 1.25rem;
    color: #dc3545;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.delete-popup-header h3 i {
    font-size: 1.1rem;
}

.close-popup-button {
    background: none;
    border: none;
    color: #6c757d;
    font-size: 1.25rem;
    cursor: pointer;
    padding: 0.25rem;
    border-radius: 50%;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
}

.close-popup-button:hover {
    background: #f8f9fa;
    color: #495057;
}

.delete-popup-content {
    padding: 1.5rem;
}

.delete-popup-content p {
    margin: 0 0 0.75rem 0;
    font-size: 1rem;
    color: #212529;
}

.comment-preview {
    background: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 6px;
    padding: 0.75rem;
    margin-top: 1rem;
}

.preview-header {
    margin-bottom: 0.5rem;
    color: #495057;
    font-size: 0.9rem;
}

.preview-text {
    color: #6c757d;
    font-size: 0.9rem;
    line-height: 1.4;
    white-space: pre-wrap;
    overflow-wrap: break-word;
    word-wrap: break-word;
    word-break: break-word;
}

.delete-popup-actions {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
    padding: 1rem 1.5rem;
    border-top: 1px solid #e9ecef;
    background: #f8f9fa;
}

.delete-popup-button {
    padding: 0.625rem 1.5rem;
    border-radius: 6px;
    font-size: 0.95rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    border: 1px solid transparent;
    min-width: 100px;
    text-align: center;
}

.cancel-delete-button {
    background: #6c757d;
    color: white;
    border-color: #6c757d;
}

.cancel-delete-button:hover:not(:disabled) {
    background: #5a6268;
    border-color: #545b62;
}

.confirm-delete-button {
    background: #dc3545;
    color: white;
    border-color: #dc3545;
}

.confirm-delete-button:hover:not(:disabled) {
    background: #c82333;
    border-color: #bd2130;
}

.delete-popup-button:disabled {
    opacity: 0.65;
    cursor: not-allowed;
}

.confirm-delete-button.loading {
    background: #dc3545;
    border-color: #dc3545;
    opacity: 0.8;
}

.confirm-delete-button.loading i {
    margin-right: 0.5rem;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.confirm-delete-button.admin-delete {
    background: #3182ce;
    border-color: #3182ce;
}

.confirm-delete-button.admin-delete:hover:not(:disabled) {
    background: #2c5282;
    border-color: #2a4365;
}

.confirm-delete-button.admin-delete.hard-delete {
    background: #2b6cb0;
    border-color: #2b6cb0;
}

.confirm-delete-button.admin-delete.hard-delete:hover:not(:disabled) {
    background: #2c5282;
    border-color: #2a4365;
}

/* Autentifikācijas uznirstošo logu stili */
.auth-popup-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    animation: fadeIn 0.2s ease;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

.auth-popup {
    background: white;
    border-radius: 12px;
    width: 90%;
    max-width: 400px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
    animation: popIn 0.3s ease;
}

@keyframes popIn {
    from {
        opacity: 0;
        transform: scale(0.9) translateY(20px);
    }
    to {
        opacity: 1;
        transform: scale(1) translateY(0);
    }
}

.auth-popup-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.25rem 1.5rem;
    border-bottom: 1px solid #eee;
}

.auth-popup-header h3 {
    margin: 0;
    font-size: 1.25rem;
    color: #333;
}

.close-popup-button {
    background: none;
    border: none;
    color: #666;
    font-size: 1.25rem;
    cursor: pointer;
    padding: 0.25rem;
    border-radius: 4px;
    transition: all 0.2s;
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.close-popup-button:hover {
    background: #f5f5f5;
    color: #333;
}

.auth-popup-content {
    padding: 1.5rem;
}

.auth-popup-content p {
    margin: 0 0 1.5rem 0;
    color: #666;
    font-size: 1rem;
    line-height: 1.5;
    text-align: center;
}

.auth-popup-actions {
    display: flex;
    gap: 1rem;
    justify-content: center;
}

.auth-popup-button {
    padding: 0.75rem 1.5rem;
    border-radius: 6px;
    font-size: 0.95rem;
    font-weight: 500;
    text-decoration: none;
    cursor: pointer;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    min-width: 120px;
    max-width: 140px;
    border: none;
}

.auth-popup-button i {
    font-size: 0.9rem;
}

.login-button {
    background: #0c4baa;
    color: white;
    border: 1px solid #0c4baa;
}

.login-button:hover {
    background: #1a5fc9;
    border-color: #1a5fc9;
    transform: translateY(-1px);
}

.signup-button {
    background: white;
    color: #0c4baa;
    border: 1px solid #0c4baa;
}

.signup-button:hover {
    background: #f0f4ff;
    border-color: #1a5fc9;
    transform: translateY(-1px);
}

@media (max-width: 1455px) {
    .artist-page {
        width: 90%;
    }
}

@media (max-width: 1230px) {
    .release-info h3 {
        font-size: 0.8rem;
    }
}

@media (max-width: 1024px) {
    .artist-page {
        max-width: 100%;
        width: 100%;
        padding: 0 10px;
    }

    .artist-content {
        flex-direction: column;
        gap: 10px;
    }

    .artist-hero {
        margin-bottom: 0.5rem;
    }

    .artist-description {
        margin-bottom: 1rem;
    }

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

@media (max-width: 768px) {
    .artist-hero {
        height: 220px;
    }

    .artist-name {
        font-size: 2rem;
        padding: 1rem;
    }

    .main-content {
        max-width: 100%;
        width: 100%;
    }

    .sidebar-space {
        display: none;
    }

    .artist-side-info {
        flex-direction: column;
    }

    .info-card {
        width: 100%;
    }

    .track-card {
        padding: 0.75rem;
        gap: 0.75rem;
    }

    .track-image {
        width: 45px;
        height: 45px;
    }

    .track-info {
        padding: 0 0.25rem;
    }

    .track-duration {
        flex: 0 0 50px;
    }

    .add-comment-section {
        padding: 0.75rem 1rem;
        margin-bottom: 1.5rem;
    }

    .placeholder-content {
        font-size: 0.95rem;
    }

    .placeholder-content i {
        font-size: 1rem;
    }

    .comment-textarea {
        font-size: 0.9rem;
        padding: 0.625rem;
    }

    .comment-action-button {
        padding: 0.5rem 1rem;
        font-size: 0.9rem;
        min-width: 80px;
    }

    .auth-prompt {
        font-size: 0.9rem;
        padding: 0.5rem 0;
    }

    .comment-item {
        margin-left: 0 !important;
        padding-left: 0.5rem;
    }

    .comment-item.depth-1 {
        margin-left: 30px !important;
        padding-left: 0.75rem;
    }

    .comment-item.depth-2 {
        margin-left: 60px !important;
        padding-left: 0.75rem;
    }

    .comment-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.25rem;
    }

    .comment-time {
        font-size: 0.8rem;
    }

    .comment-header-right {
        gap: 0.5rem;
    }

    .comment-menu-button {
        width: 28px;
        height: 28px;
        font-size: 0.9rem;
        padding: 0.25rem;
    }

    .comment-dropdown-menu {
        min-width: 130px;
    }

    .dropdown-item {
        padding: 0.625rem 0.875rem;
        font-size: 0.85rem;
        gap: 0.625rem;
    }

    .dropdown-item i {
        font-size: 0.85rem;
    }

    .comment-item.depth-1 .read-more-less-button,
    .comment-item.depth-2 .read-more-less-button {
        margin-left: 0.75rem;
    }

    .read-more-less-button {
        font-size: 0.8rem;
        padding: 0.2rem 0;
    }

    .reply-button {
        font-size: 0.8rem;
        padding: 0.2rem 0.625rem;
        gap: 0.25rem;
    }

    .reply-button i {
        font-size: 0.85rem;
    }

    .reply-form {
        margin-left: 0.5rem;
        padding: 0.625rem;
        margin-top: 0.75rem;
    }

    .reply-textarea {
        font-size: 0.85rem;
        padding: 0.5rem;
        min-height: 55px;
    }

    .reply-action-button {
        padding: 0.3rem 0.875rem;
        font-size: 0.85rem;
        min-width: 65px;
    }

    .reply-actions {
        gap: 0.5rem;
    }

    .auth-popup {
        width: 95%;
        max-width: 350px;
    }

    .auth-popup-header {
        padding: 1rem;
    }

    .auth-popup-content {
        padding: 1.25rem;
    }

    .auth-popup-button {
        padding: 0.625rem 1.25rem;
        font-size: 0.9rem;
        min-width: 100px;
    }

    .auth-popup-actions {
        gap: 0.75rem;
    }

    .comment-item.depth-1 .reply-button,
    .comment-item.depth-2 .reply-button {
        margin-left: 0.75rem;
    }

    .delete-popup {
        width: 95%;
        margin: 0 1rem;
    }

    .delete-popup-header {
        padding: 1rem 1.25rem;
    }

    .delete-popup-header h3 {
        font-size: 1.1rem;
    }

    .delete-popup-content {
        padding: 1.25rem;
    }

    .delete-popup-actions {
        padding: 0.75rem 1.25rem;
    }

    .delete-popup-button {
        padding: 0.5rem 1rem;
        min-width: 80px;
        font-size: 0.9rem;
    }

    .admin-badge {
        font-size: 0.65rem;
        padding: 0.15rem 0.4rem;
        margin-left: 0.5rem;
    }
}

@media (max-width: 480px) {
    .info-item {
        flex: 1 0 100%;
    }

    .track-card {
        padding: 0.5rem;
        gap: 0.5rem;
    }

    .track-image {
        width: 40px;
        height: 40px;
    }

    .track-number {
        width: 20px;
    }

    .track-title {
        font-size: 0.9rem;
    }

    .track-duration {
        font-size: 0.85rem;
        flex: 0 0 45px;
    }

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

    .comment-actions {
        flex-direction: column;
        gap: 0.5rem;
    }

    .comment-action-button {
        width: 100%;
        min-width: unset;
    }

    .add-comment-section {
        padding: 0.625rem;
        margin-bottom: 1rem;
    }

    .comment-header {
        flex-wrap: nowrap;
    }

    .comment-header-right {
        flex-shrink: 0;
    }

    .comment-time {
        font-size: 0.75rem;
        white-space: nowrap;
    }

    .comment-menu-button {
        width: 24px;
        height: 24px;
        font-size: 0.8rem;
    }

    .comment-dropdown-menu {
        right: -8px;
        min-width: 120px;
    }

    .reply-actions {
        flex-direction: column;
        gap: 0.375rem;
    }

    .reply-action-button {
        width: 100%;
        min-width: unset;
    }

    .auth-popup-actions {
        margin: auto;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }

    .auth-popup-button {
        width: 100%;
        min-width: unset;
    }

    .delete-popup-actions {
        flex-direction: column;
    }

    .delete-popup-button {
        width: 100%;
        min-width: unset;
    }

    .admin-badge {
        display: none;
    }
}

</style>
