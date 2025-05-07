<template>
    <footer class="footer">
        <div class="footer-content">
            <!-- footer links -->
            <div class="footer-section">
                <h4 class="footer-heading">Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="/about">About Us</a></li>
                    <li><a href="/contact">Contact Us</a></li>
                    <li><a href="/privacy-policy">Privacy Policy</a></li>
                    <li><a href="/terms-of-service">Terms of Service</a></li>
                    <li><a href="/faq">FAQ</a></li>
                    <li><a href="#">Community Guidelines</a></li>
                </ul>
            </div>
        </div>

        <!-- copyright -->
        <div class="footer-bottom">
            <p>&copy; {{ currentYear }} Made by Danon © Know Your Music. All rights reserved.</p>
        </div>
    </footer>
</template>

<script setup>

const currentYear = new Date().getFullYear();

</script>

<style scoped>
.footer {
    font-family: Arial, Helvetica, sans-serif;
    background-color: rgb(185, 225, 255);
    color: #000000;
    padding: 40px 20px;
    text-align: center;
    box-shadow: 0 -4px 10px rgba(0, 0, 0, 0.2);
}

.footer-content {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    gap: 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.footer-section {
    flex: 1;
    min-width: 200px;
}

.footer-heading {
    font-size: 18px;
    margin-bottom: 15px;
}

.footer-links {
    list-style: none;
    padding: 0;
}

.footer-links li {
    margin: 10px 0;
}

.footer-links a {
    color: #000000;
    text-decoration: none;
    transition: color 0.3s ease;
}

.footer-links a:hover {
    color: #1abc9c;
}

.footer-bottom {
    margin-top: 20px;
    border-top: 1px solid #34495e;
    padding-top: 20px;
}

@media (max-width: 768px) {
    .footer-content {
        flex-direction: column;
        align-items: center;
    }
}
</style>
