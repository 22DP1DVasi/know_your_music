<script setup>
import { ref, computed, nextTick, onMounted, onBeforeUnmount } from 'vue' // nextTick ļauj izpildīt kodu pēc tam, kad vietnē ir mainīti kādi dati
import { usePage, Link } from '@inertiajs/vue3'
import axios from 'axios'
import { useDate } from '@/composables/useDate'

const props = defineProps({
    entityType: {
        type: String,
        required: true,
        validator: (value) => ['artist', 'release', 'track', 'genre'].includes(value)
    },
    entitySlug: {
        type: String,
        required: true
    },
    entityId: {
        type: Number,
        required: true
    },
    parentKey: {
        type: String,
        required: true, // piemēram, 'artist_id', 'release_id', 'track_id', 'genre_id'
        default: 'entity_id' // noklusējums
    },
    initialComments: {
        type: Array,
        default: () => []
    },
    initialPagination: {
        type: Object,
        default: () => ({
            current_page: 1,
            last_page: 1,
            total: 0,
            per_page: 10
        })
    }
})

// piekļuve koplietojamiem datiem no servera puses
const page = usePage()

// iegūt pašreizējo lietotāju un lomas
const currentUser = page.props.auth?.user
const roles = computed(() => currentUser?.roles ?? [])
const isCommentsModerator = computed(() => ['comments_moderator', 'super_admin']
    .some(role => roles.value.includes(role)))

const { formatDateLL, fromNow, diffInMinutes } = useDate()

// reaktīvas vērtības
const comments = ref(props.initialComments || [])
const commentsPagination = ref(props.initialPagination)
const loadingComments = ref(false)
const expandedComments = ref(new Set())
const commentMaxLength = 400
const isAuthenticated = computed(() => !!currentUser)

// komentāru ievades stāvokļi
const isAddingComment = ref(false)
const newCommentText = ref('')
const isSubmittingComment = ref(false)

// atbīldes stāvokļi
const replyingToCommentId = ref(null)
const replyText = ref('')
const isSubmittingReply = ref(false)
const showAuthPopup = ref(false)
const authPopupCommentId = ref(null)

// darbību izvēlnes stāvokļi
const activeCommentMenu = ref(null)
const showDeletePopup = ref(false)
const commentToDelete = ref(null)
const isDeletingComment = ref(false)

// rediģēšanas stāvokļi
const editingCommentId = ref(null)
const editingCommentText = ref('')
const isSubmittingEdit = ref(false)

// computed vērtības
const showLoadMore = computed(() => {
    return commentsPagination.value.current_page < commentsPagination.value.last_page
})

const canSubmitComment = computed(() => {
    return newCommentText.value.trim().length > 0 && !isSubmittingComment.value
})

const canSubmitEdit = (commentId) => {
    return editingCommentId.value === commentId &&
        editingCommentText.value.trim().length > 0 &&
        !isSubmittingEdit.value
}

const canSubmitReply = (commentId) => {
    return replyingToCommentId.value === commentId &&
        replyText.value.trim().length > 0 &&
        !isSubmittingReply.value
}

// API galapunkti
const getBaseApiPath = () => {
    return `/${props.entityType}s/${props.entitySlug}/comments`
}

const getCommentApiPath = (commentId) => {
    return `/${props.entityType}s/${props.entitySlug}/comments/${commentId}`
}

// lietotāja tiesību metodes
const isUserComment = (comment) => {
    if (!isAuthenticated.value || !comment.user) return false
    return comment.user.id === currentUser?.id
}

const canSeeActionMenu = (comment) => {
    if (!isAuthenticated.value) return false
    return isUserComment(comment) || isCommentsModerator.value
}

const canEditComment = (comment) => {
    if (!isAuthenticated.value) return false
    if (!isUserComment(comment)) return false
    const minutesSinceCreation = diffInMinutes(comment.created_at)
    return minutesSinceCreation <= 15
}

const isCommentEdited = (comment) => {
    return comment.edited_at !== null && comment.edited_at !== undefined
}

const canDeleteComment = (comment) => {
    if (!isAuthenticated.value) return false
    return isUserComment(comment) || isCommentsModerator.value
}

const getDeleteButtonInfo = (comment) => {
    if (isCommentsModerator.value && !isUserComment(comment)) {
        return {
            label: 'Delete (Admin)',
            icon: 'fa-solid fa-shield',
            isAdmin: true
        }
    } else {
        return {
            label: 'Delete',
            icon: 'fa-regular fa-trash-can',
            isAdmin: false
        }
    }
}

const canBeHardDeleted = (comment) => {
    const hasReplies = comment.replies && comment.replies.length > 0
    const isReply = comment.parent_id !== null
    return !hasReplies && !isReply
}

// komentāra teksta metodes
const needsTruncation = (comment) => {
    if (!comment?.text) return false
    const plainText = comment.text.replace(/<[^>]*>/g, '')
    return plainText.length > commentMaxLength
}

const getTruncatedText = (comment) => {
    if (!comment?.text) return ''
    const plainText = comment.text.replace(/<[^>]*>/g, '')
    if (plainText.length <= commentMaxLength) return comment.text

    let truncated = plainText.substring(0, commentMaxLength)
    const lastPeriod = truncated.lastIndexOf('.')
    const lastExclamation = truncated.lastIndexOf('!')
    const lastQuestion = truncated.lastIndexOf('?')
    const breakPoints = [lastPeriod, lastExclamation, lastQuestion].filter(pos => pos > 0)

    if (breakPoints.length > 0) {
        const lastBreak = Math.max(...breakPoints)
        if (lastBreak > commentMaxLength * 0.7) {
            truncated = truncated.substring(0, lastBreak + 1)
        }
    } else {
        const lastSpace = truncated.lastIndexOf(' ')
        if (lastSpace > commentMaxLength * 0.8) {
            truncated = truncated.substring(0, lastSpace)
        }
    }
    return truncated.trim() + '...'
}

const getFullText = (comment) => {
    return comment?.text || ''
}

const toggleCommentExpansion = (commentId) => {
    if (expandedComments.value.has(commentId)) {
        expandedComments.value.delete(commentId)
    } else {
        expandedComments.value.add(commentId)
    }
}

const isCommentExpanded = (commentId) => {
    return expandedComments.value.has(commentId)
}

const getDisplayText = (comment) => {
    if (!comment?.id) return ''
    if (isCommentExpanded(comment.id) || !needsTruncation(comment)) {
        return getFullText(comment)
    } else {
        return getTruncatedText(comment)
    }
}

const isCommentDeleted = (comment) => {
    return comment.deleted_at !== null && comment.deleted_at !== undefined
}

const getDisplayTextConsideringDeletion = (comment) => {
    if (isCommentDeleted(comment)) {
        return '<em class="deleted-comment-text">This comment has been deleted.</em>'
    }
    return getDisplayText(comment)
}

const needsTruncationWithDeletion = (comment) => {
    if (isCommentDeleted(comment)) return false
    return needsTruncation(comment)
}

// helper komentāru saplacināšanai
const renderComment = (comment, depth = 0) => {
    const maxDepth = 2
    const actualDepth = Math.min(depth, maxDepth)
    return {
        comment,
        depth: actualDepth,
        hasReplies: comment.replies && comment.replies.length > 0
    }
}

const displayComments = computed(() => {
    const flattenComments = (commentList, depth = 0) => {
        let result = []
        commentList.forEach(comment => {
            result.push(renderComment(comment, depth))
            if (comment.replies && comment.replies.length > 0) {
                const replies = flattenComments(comment.replies, depth + 1)
                result = [...result, ...replies]
            }
        })
        return result
    }
    return flattenComments(comments.value)
})

// pamatmetodes
const autoResizeTextarea = async (event) => {
    await nextTick()
    const el = event.target
    if (!el) return
    el.style.height = 'auto'
    el.style.height = el.scrollHeight + 'px'
}

// API metodes
const loadMoreComments = async () => {
    if (loadingComments.value || !showLoadMore.value) return
    loadingComments.value = true
    const nextPage = commentsPagination.value.current_page + 1

    try {
        const response = await axios.get(getBaseApiPath(), {
            params: { page: nextPage }
        })
        comments.value = [...comments.value, ...response.data.comments]
        commentsPagination.value = {
            ...commentsPagination.value,
            current_page: response.data.pagination.current_page,
            last_page: response.data.pagination.last_page
        }
    } catch (error) {
        console.error('Error loading comments:', error)
    } finally {
        loadingComments.value = false
    }
}

// komentāra pievienošanas metodes
const startAddingComment = async () => {
    if (!isAuthenticated.value) return
    isAddingComment.value = true
    await nextTick()
    document.querySelector('.comment-textarea')?.focus()
}

const cancelAddingComment = () => {
    isAddingComment.value = false
    newCommentText.value = ''
    isSubmittingComment.value = false
}

const submitComment = async () => {
    if (!newCommentText.value.trim() || !isAuthenticated.value || isSubmittingComment.value) {
        return
    }
    isSubmittingComment.value = true
    try {
        // izmantot dinamisko vecākatslēgu, pamatojoties uz entītijas tipu
        const requestData = {
            text: newCommentText.value.trim(),
            parent_id: null
        }
        // pievienot atbilstošo vecākatslēgu (artist_id, release_id, utt.)
        requestData[props.parentKey] = props.entityId
        const response = await axios.post(getBaseApiPath(), requestData)
        isAddingComment.value = false
        newCommentText.value = ''
        const newComment = response.data.comment
        comments.value = [newComment, ...comments.value]
        commentsPagination.value.total += 1
        await nextTick()
        const firstComment = document.querySelector('.comment-item:first-child')
        firstComment?.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
    } catch (error) {
        console.error('Error submitting comment:', error)
        alert('Failed to submit comment. Please try again.')
    } finally {
        isSubmittingComment.value = false
    }
}

// atbilžu metodes
const startAddingReply = async (commentId) => {
    if (!isAuthenticated.value) {
        authPopupCommentId.value = commentId
        showAuthPopup.value = true
        return
    }
    replyingToCommentId.value = commentId
    replyText.value = ''
    await nextTick()
    const textarea = document.querySelector('.reply-textarea')
    textarea?.focus()
    const replyForm = document.querySelector(`.reply-form-${commentId}`)
    replyForm?.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
}

const cancelReply = () => {
    replyingToCommentId.value = null
    replyText.value = ''
    isSubmittingReply.value = false
}

const submitReply = async (parentCommentId) => {
    if (!replyText.value.trim() || !isAuthenticated.value || isSubmittingReply.value) {
        return
    }
    isSubmittingReply.value = true
    try {
        // izmantot dinamisko vecākatslēgu, pamatojoties uz entītijas tipu
        const requestData = {
            text: replyText.value.trim(),
            parent_id: parentCommentId
        }
        // pievienot atbilstošo vecākatslēgu (artist_id, release_id, utt.)
        requestData[props.parentKey] = props.entityId
        const response = await axios.post(getBaseApiPath(), requestData)
        const addReplyToComment = (commentList, parentId, newReply) => {
            for (let comment of commentList) {
                if (comment.id === parentId) {
                    if (!comment.replies) comment.replies = []
                    comment.replies.push(newReply)
                    return true
                }
                if (comment.replies && comment.replies.length > 0) {
                    if (addReplyToComment(comment.replies, parentId, newReply)) {
                        return true
                    }
                }
            }
            return false
        }
        const newReply = response.data.comment
        addReplyToComment(comments.value, parentCommentId, newReply)
        replyingToCommentId.value = null
        replyText.value = ''
        commentsPagination.value.total += 1
    } catch (error) {
        console.error('Error submitting reply:', error)
        alert('Failed to submit reply. Please try again.')
    } finally {
        isSubmittingReply.value = false
    }
}

const closeAuthPopup = () => {
    showAuthPopup.value = false
    authPopupCommentId.value = null
}

// darbību izvēlnes metodes
const toggleCommentMenu = (commentId, event) => {
    if (event) event.stopPropagation()

    if (activeCommentMenu.value === commentId) {
        activeCommentMenu.value = null
    } else {
        activeCommentMenu.value = commentId
    }
}

const closeCommentMenu = () => {
    activeCommentMenu.value = null
}

const handleClickOutside = (event) => {
    if (!event.target.closest('.comment-menu-button') &&
        !event.target.closest('.comment-dropdown-menu')) {
        closeCommentMenu()
    }
}

onMounted(() => {
    document.addEventListener('click', handleClickOutside)
})

onBeforeUnmount(() => {
    document.removeEventListener('click', handleClickOutside)
})

// rediģēšanas metodes
const handleEditComment = (comment) => {
    if (!canEditComment(comment)) {
        alert('You can only edit your own comments within 15 minutes of posting.')
        return
    }
    startEditingComment(comment)
}

const startEditingComment = (comment) => {
    closeCommentMenu()
    editingCommentId.value = comment.id
    editingCommentText.value = comment.text || ''

    nextTick(() => {
        const textarea = document.querySelector(`.edit-textarea-${comment.id}`)
        if (textarea) {
            textarea.focus()
            textarea.setSelectionRange(textarea.value.length, textarea.value.length)
            const editForm = document.querySelector(`.edit-form-${comment.id}`)
            editForm?.scrollIntoView({ behavior: 'smooth', block: 'nearest' })
        }
    })
}

const cancelEditingComment = () => {
    editingCommentId.value = null
    editingCommentText.value = ''
    isSubmittingEdit.value = false
}

const submitEditedComment = async (commentId) => {
    if (!editingCommentText.value.trim() || isSubmittingEdit.value) {
        return
    }
    isSubmittingEdit.value = true
    try {
        const response = await axios.put(getCommentApiPath(commentId), {
            text: editingCommentText.value.trim()
        })
        if (response.data.success) {
            const updateCommentText = (commentList, targetCommentId, newText, editedAt) => {
                for (let comment of commentList) {
                    if (comment.id === targetCommentId) {
                        comment.text = newText
                        comment.edited_at = editedAt
                        comment.updated_at = new Date().toISOString()
                        return true
                    }
                    if (comment.replies && comment.replies.length > 0) {
                        if (updateCommentText(comment.replies, targetCommentId, newText, editedAt)) {
                            return true
                        }
                    }
                }
                return false
            }
            updateCommentText(
                comments.value,
                commentId,
                response.data.comment.text,
                response.data.comment.edited_at
            )
            cancelEditingComment()
        }
    } catch (error) {
        console.error('Error updating comment:', error)
        if (error.response?.status === 403) {
            alert('You are not authorized to edit this comment or the edit time limit has expired.')
        } else if (error.response?.status === 422) {
            alert('Please provide valid comment text.')
        } else {
            alert('Failed to update comment. Please try again.')
        }
    } finally {
        isSubmittingEdit.value = false
    }
}

// dzēšanas metodes
const handleDeleteComment = (comment) => {
    initiateDeleteComment(comment)
}

const initiateDeleteComment = (comment) => {
    closeCommentMenu()
    commentToDelete.value = {
        ...comment,
        isAdminDelete: isCommentsModerator.value && !isUserComment(comment)
    }
    showDeletePopup.value = true
}

const cancelDelete = () => {
    showDeletePopup.value = false
    commentToDelete.value = null
    isDeletingComment.value = false
}

const getDeleteConfirmationMessage = () => {
    if (!commentToDelete.value) return ''
    const isAdminDelete = commentToDelete.value.isAdminDelete
    if (isAdminDelete) {
        if (canBeHardDeleted(commentToDelete.value)) {
            return 'This comment will be permanently deleted as an administrator action.'
        } else {
            return 'This comment will be deleted (admin action) but kept for thread continuity.'
        }
    } else {
        return 'Are you sure you want to delete this comment permanently?'
    }
}

const markCommentAsDeleted = (commentList, commentId, deletedAt) => {
    for (let comment of commentList) {
        if (comment.id === commentId) {
            comment.deleted_at = deletedAt
            comment.text = null
            return true
        }
        if (comment.replies?.length) {
            if (markCommentAsDeleted(comment.replies, commentId, deletedAt)) {
                return true
            }
        }
    }
    return false
}

const removeCommentFromTree = (commentList, commentId) => {
    const index = commentList.findIndex(c => c.id === commentId)
    if (index !== -1) {
        commentList.splice(index, 1)
        return true
    }
    for (let comment of commentList) {
        if (comment.replies?.length) {
            if (removeCommentFromTree(comment.replies, commentId)) {
                return true
            }
        }
    }
    return false
}

const confirmDeleteComment = async () => {
    if (!commentToDelete.value || isDeletingComment.value) return
    isDeletingComment.value = true
    try {
        const response = await axios.delete(getCommentApiPath(commentToDelete.value.id))

        if (response.data.success) {
            const { delete_type, deleted_at } = response.data
            if (delete_type === 'hard') {
                removeCommentFromTree(comments.value, commentToDelete.value.id)
            } else {
                markCommentAsDeleted(
                    comments.value,
                    commentToDelete.value.id,
                    deleted_at ?? new Date().toISOString()
                )
            }
        }
    } catch (error) {
        console.error('Error deleting comment:', error)
        if (error.response?.status === 403) {
            alert('You are not authorized to delete this comment.')
        } else {
            alert('Failed to delete comment. Please try again.')
        }
    } finally {
        showDeletePopup.value = false
        commentToDelete.value = null
        isDeletingComment.value = false
    }
}

</script>

<template>
    <section class="comments-section">
        <h2 class="section-title">Comments ({{ commentsPagination.total }})</h2>

        <!-- Komentāra pievienošanas sekcija -->
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

        <!-- Esošo komentāru sekcija -->
        <div class="comments-section">
            <div v-if="displayComments.length === 0" class="no-comments">
                <p>No comments yet. Be the first to comment!</p>
            </div>

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
                        <div class="comment-time-container">
                            <span class="comment-time"
                                  :title="formatDateLL(commentData.comment.created_at)">
                                {{ fromNow(commentData.comment.created_at) }}
                            </span>
                            <span v-if="!isCommentDeleted(commentData.comment) && isCommentEdited(commentData.comment)"
                                  class="edited-badge"
                                  :title="'Edited at ' + formatDateLL(commentData.comment.edited_at)">
                                <i class="fa-regular fa-pen-to-square"></i> edited
                            </span>
                        </div>

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

                            <!-- Nolaižamā izvēlne -->
                            <div
                                v-if="activeCommentMenu === commentData.comment.id"
                                class="comment-dropdown-menu"
                                @click.stop=""
                                :class="{ 'admin-dropdown': isCommentsModerator && !isUserComment(commentData.comment) }"
                            >
                                <button
                                    v-if="canEditComment(commentData.comment)"
                                    class="dropdown-item edit-item"
                                    @click="handleEditComment(commentData.comment)"
                                >
                                    <i class="fa-regular fa-pen-to-square"></i>
                                    <span>Edit</span>
                                </button>
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

                <!-- Rādīt rediģēšanas veidlapu, ja šis komentārs tiek rediģēts -->
                <div v-if="!isCommentDeleted(commentData.comment) && editingCommentId === commentData.comment.id"
                     :class="['edit-comment-form', `edit-form-${commentData.comment.id}`]">
                    <div class="edit-input-wrapper">
                        <textarea
                            v-model="editingCommentText"
                            :class="['edit-textarea', `edit-textarea-${commentData.comment.id}`]"
                            placeholder="Edit your comment..."
                            rows="3"
                            maxlength="2000"
                            @input="autoResizeTextarea"
                        />
                        <div class="edit-char-count" :class="{ 'near-limit': editingCommentText.length > 1800 }">
                            {{ editingCommentText.length }}/2000
                        </div>
                    </div>

                    <div class="edit-actions">
                        <button
                            @click="cancelEditingComment"
                            class="edit-action-button cancel-edit-button"
                            :disabled="isSubmittingEdit"
                        >
                            Cancel
                        </button>
                        <button
                            @click="submitEditedComment(commentData.comment.id)"
                            class="edit-action-button submit-edit-button"
                            :disabled="!canSubmitEdit(commentData.comment.id)"
                            :class="{ 'loading': isSubmittingEdit }"
                        >
                            <span v-if="isSubmittingEdit">
                                <i class="fa-solid fa-spinner fa-spin"></i> Saving...
                            </span>
                            <span v-else>Save changes</span>
                        </button>
                    </div>
                </div>

                <div v-else>
                    <div
                        :class="['comment-text', {
                            'truncated': !isCommentExpanded(commentData.comment.id) && needsTruncationWithDeletion(commentData.comment),
                            'deleted-comment': isCommentDeleted(commentData.comment)
                        }]"
                        v-html="getDisplayTextConsideringDeletion(commentData.comment)"
                    ></div>

                    <button
                        v-if="!isCommentDeleted(commentData.comment) && needsTruncationWithDeletion(commentData.comment)"
                        @click="toggleCommentExpansion(commentData.comment.id)"
                        class="read-more-less-button"
                    >
                        {{ isCommentExpanded(commentData.comment.id) ? 'Read less' : 'Read more' }}
                    </button>

                    <button
                        v-if="!isCommentDeleted(commentData.comment)"
                        @click="startAddingReply(commentData.comment.id)"
                        class="reply-button"
                    >
                        <i class="fa-regular fa-comment-dots"></i> Reply
                    </button>

                    <!-- Atbildes veidlapa -->
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

            <!-- Poga Rādīt vairāk komentāru -->
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

    <!-- Dzēšanas apstiprinājuma uznirstošais logs -->
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

/* rediģēt komentāru stili */
.edit-comment-form {
    margin: 0.75rem 0;
    padding: 1rem;
    background: #f8f9fa;
    border-radius: 8px;
    border: 1px solid #e9ecef;
    animation: slideDown 0.2s ease;
}

.edit-input-wrapper {
    position: relative;
    margin-bottom: 1rem;
}

.edit-textarea {
    width: 100%;
    padding: 0.75rem;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    font-family: inherit;
    font-size: 0.95rem;
    line-height: 1.5;
    resize: vertical;
    min-height: 80px;
    max-height: 200px;
    transition: border-color 0.2s, box-shadow 0.2s;
}

.edit-textarea:focus {
    outline: none;
    border-color: #4dabf7;
    box-shadow: 0 0 0 3px rgba(77, 171, 247, 0.1);
}

.edit-char-count {
    position: absolute;
    bottom: 0.5rem;
    right: 0.75rem;
    font-size: 0.8rem;
    color: #999;
    background: white;
    padding: 0 0.25rem;
    transition: color 0.2s;
}

.edit-char-count.near-limit {
    color: #ff6b6b;
    font-weight: 500;
}

.edit-actions {
    display: flex;
    justify-content: flex-end;
    gap: 0.75rem;
}

.edit-action-button {
    padding: 0.5rem 1.25rem;
    border-radius: 4px;
    font-size: 0.95rem;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    border: none;
    min-width: 90px;
    text-align: center;
}

.cancel-edit-button {
    background: #f5f5f5;
    color: #666;
    border: 1px solid #ddd;
}

.cancel-edit-button:hover:not(:disabled) {
    background: #eaeaea;
    color: #333;
}

.cancel-edit-button:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.submit-edit-button {
    background: #4dabf7;
    color: white;
    border: 1px solid #4dabf7;
}

.submit-edit-button:hover:not(:disabled) {
    background: #339af0;
    border-color: #339af0;
}

.submit-edit-button:disabled {
    background: #ccc;
    border-color: #ccc;
    cursor: not-allowed;
    color: #999;
}

.submit-edit-button.loading {
    background: #4dabf7;
    border-color: #4dabf7;
    opacity: 0.8;
}

.submit-edit-button.loading i {
    margin-right: 0.5rem;
}

/* rediģētas emblēmas stili */
.comment-time-container {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.edited-badge {
    background: #e7f5ff;
    color: #1971c2;
    font-size: 0.75rem;
    padding: 0.15rem 0.5rem;
    border-radius: 10px;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
    border: 1px solid #a5d8ff;
}

.edited-badge i {
    font-size: 0.7rem;
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

/* noņemt izbalēšanu izvēršanas laikā */
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

/* izdzēsto komentāru stili */
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

/* dzēstā apstiprinājuma uznirstošā loga stili */
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

@media (max-width: 768px) {
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

    .edit-comment-form {
        padding: 0.75rem;
        margin: 0.5rem 0;
    }

    .edit-textarea {
        font-size: 0.9rem;
        padding: 0.625rem;
    }

    .edit-action-button {
        padding: 0.5rem 1rem;
        font-size: 0.9rem;
        min-width: 80px;
    }

    .edited-badge {
        font-size: 0.7rem;
        padding: 0.1rem 0.4rem;
        gap: 0.15rem;
    }
}

@media (max-width: 480px) {
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

    .edit-actions {
        flex-direction: column;
    }

    .edit-action-button {
        width: 100%;
        min-width: unset;
    }

    .comment-time-container {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.25rem;
    }

    .edited-badge {
        align-self: flex-start;
    }
}

</style>
