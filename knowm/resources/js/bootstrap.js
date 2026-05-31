import axios from 'axios';
window.axios = axios;

window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

// not_banned middleware for Axios
axios.interceptors.response.use(
    response => response,
    error => {

        if (error.response?.status === 403) {
            window.location.href = '/account-banned';
        }

        return Promise.reject(error);
    }
);
