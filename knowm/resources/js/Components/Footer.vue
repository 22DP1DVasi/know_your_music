<template>
  <footer class="footer">
    <div class="footer-sections">
      <ul class="footer-links">
        <li><a href="#">FAQ</a></li>
        <li><a href="#">User Agreement</a></li>
        <li><a href="#">Rules</a></li>
      </ul>
      <ul class="footer-links">
        <li><a href="#">Copyright</a></li>
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
  gap: 20px; /* Add spacing between sections */
  justify-content: center; /* Center align all footer content */
}

/* Section container */
.footer-sections {
  display: flex;
  justify-content: center;
  gap: 40px; /* Space between columns */
  flex-wrap: wrap; /* Wrap on smaller screens */
  width: 100%; /* Ensure it takes up the full width */
  max-width: 900px; /* Prevent content from stretching too wide */
  box-sizing: border-box;
}

/* Footer Links */
.footer-links {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin: 5px 0; /* Add vertical spacing between items */
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
  margin-top: 20px; /* Add spacing to ensure it's visually separated */

  
}

/* Responsive Design */
@media screen and (max-width: 768px) {
  .footer-sections {
    flex-direction: column; /* Stack columns vertically */
    align-items: center; /* Center-align content */
    gap: 20px;
    padding: 0 10px; /* Add slight padding to avoid edges */
  }
}

@media screen and (max-width: 480px) {
  .footer {
    padding: 5px;
  }

  .footer-branding {
    font-size: 0.8rem; /* Reduce text size for smaller devices */
  }

  .footer-sections {
    gap: 15px; /* Reduce the space between sections on extra small screens */
  }
}
</style>
