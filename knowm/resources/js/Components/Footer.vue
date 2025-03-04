<template>
  <footer class="footer">
    <div class="footer-sections">
      <ul class="footer-links">
        <li><a href="/faq">FAQ</a></li>
        <li><a href="#">User Agreement</a></li>
        <li><a href="#">Rules</a></li>
      </ul>
      <ul class="footer-links">
        <li><a href="#">Help</a></li>
        <li><a href="#">Privacy Policy</a></li>
        <li><a href="#">Terms of Service</a></li>
      </ul>
    </div>
    <div class="footer-branding">
      <span>Made by Danon © 2025 Know Your Music. All rights reserved.</span>
    </div>
  </footer>
</template>

<style scoped>
/* General Footer Styles */
.footer {
    font-family: Arial, Helvetica, sans-serif;
    background-color: rgb(185, 225, 255);
    text-align: center;
    padding: 20px;
    width: 100%;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 2px 15px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px; /* add spacing between sections */
    justify-content: center; /* center align all footer content */
    position: absolute;
    top: 100%;
    width: 100%;
    height: 180px;
    bottom: 0%;
}

/* Section container */
.footer-sections {
  display: flex;
  justify-content: center;
  gap: 40px;
  flex-wrap: wrap;
  width: 100%;
  max-width: 900px;
  box-sizing: border-box;
}

/* Footer Links */
.footer-links {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin: 5px 0;
}

.footer a {
  color: #000000;
  transition: color 0.3s ease;
  text-decoration: none;
  align-items: center;
}

.footer a:hover {
  color: #002a77ed;
  text-decoration: underline;
}

/* Footer Branding */
.footer-branding {
  font-size: 0.9rem;
  color: #555;
  margin-top: 20px;
}

/* Responsive Design */
@media screen and (max-width: 768px) {
  .footer-sections {
    flex-direction: column; /* stack columns vertically */
    align-items: center; /* center-align content */
    gap: 20px;
    padding: 0 10px; /* add slight padding to avoid edges */
  }
}

@media screen and (max-width: 480px) {
  .footer {
    padding: 5px;
  }

  .footer-branding {
    font-size: 0.8rem; /* reduce text size */
  }

  .footer-sections {
    gap: 15px;
  }
}
</style>
