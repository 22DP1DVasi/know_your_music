<template>

  <div class="recommendations">
          <p>Last recommendations:</p>

      <div class="flex-container">
          <div class="column">
              <img src="../../../public/images/linkinpark.jpg" alt="Linkin Park" width="200" height="200">
              <h1>Linkin Park</h1>
              <p>One of the biggest rock and metal bands in the world.</p>
              <button class="button">Listen</button>
          </div>

          <div class="column">
              <img src="../../../public/images/celldweller.jpg" alt="Celldweller" width="200" height="200">
              <h1>Celldweller</h1>
              <p>Main electro-industrial-rock musician of 2000s.</p>
              <button class="button">Listen</button>
          </div>

          <div class="column">
              <img src="../../../public/images/tallah.jpeg" alt="Tallah" width="200" height="200">
              <h1>Tallah</h1>
              <p>Representative of modern nu-metal..</p>
              <button class="button">Listen</button>
          </div>
      </div>

      <div class="flex-container">
          <div class="column">
              <img src="../../../public/images/linkinpark.jpg" alt="Linkin Park" width="200" height="200">
              <h1>Linkin Park</h1>
              <p>One of the biggest rock and metal bands in the world.</p>
              <button class="button">Listen</button>
          </div>

          <div class="column">
              <img src="../../../public/images/celldweller.jpg" alt="Celldweller" width="200" height="200">
              <h1>Celldweller</h1>
              <p>Main electro-industrial-rock musician of 2000s.</p>
              <button class="button">Listen</button>
          </div>

          <div class="column">
              <img src="../../../public/images/tallah.jpeg" alt="Tallah" width="200" height="200">
              <h1>Tallah</h1>
              <p>Representative of modern nu-metal.</p>
              <button class="button">Listen</button>
          </div>
      </div>
    </div>

  </template>

  <style scoped>

  .flex-container {
    display: flex;
    justify-content: center; /* center horizontally */
    align-items: center; /* center vertically */
    flex-wrap: wrap;
    gap: 20px;
    padding: 20px;
  }

  .column {
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    flex: 1 1 300px; /* Set card size to approximately 300px wide */
    max-width: 300px; /* Ensure cards don't exceed this width */
    min-height: 400px; /* Set a smaller height for the cards */
    border: 5px solid #007c9ced;
    padding: 15px; /* Add inner spacing */
    box-shadow: 4px 4px 8px rgba(0, 0, 0, 0.3); /* Add subtle shadow */
    border-radius: 10px; /* Rounded corners for a clean look */
    background-color: white; /* Optional: Add background color */
  }

  .column img {
    width: 100%; /* Adjust image width to match card size */
    max-height: 150px; /* Set a limit for the image height */
    object-fit: cover; /* Ensure images fit properly */
    border-radius: 8px; /* Add rounded corners to images */
    margin-bottom: 10px; /* Spacing below the image */
  }

  .column > h1 {
    font-size: 18px; /* Smaller font size */
    line-height: 1.2em;
    margin: 10px 0; /* Reduce margins */
    text-align: center;
  }

  .column > p {
    font-size: 14px; /* Smaller font size */
    text-align: center;
    margin: 10px 0; /* Reduce spacing */
  }

  .button {
    width: 100px; /* Reduce button width */
    height: 30px; /* Adjust button height */
    font-size: 14px; /* Smaller font size */
    background-color: #52ffffed;
    color: black;
    border: 2px solid #2b6fec;
    margin-top: auto; /* Push button to the bottom of the card */
  }

  .button:hover {
    box-shadow: 4px 4px 4px rgba(0, 0, 0, 0.4);
    animation: hoverUp 0.3s forwards;
  }

  .column:hover{
    box-shadow: 6px 6px 6px rgba(0, 0, 0, 0.6);
    animation: hoverUp 0.5s forwards;
  }

  .recommendations {
    padding-top: 2%;
    padding-left: 1.5%;
    font-size: 190%;
    margin-left: 2%;
    margin-bottom: 1%;
  }

  @keyframes hoverUp {
    0% {
      transform: translateY(0);
    }
    100% {
      transform: translateY(-5px) scale(1.05);
    }
  }

  @media (max-width: 1140px) {
  .flex-container {
    display: block; /* Change from flex to block layout for scrolling */
    overflow-x: auto; /* Enable horizontal scrolling */
    white-space: nowrap; /* Prevent wrapping to new lines */
    padding: 10px;
  }

  .column {
    display: inline-block; /* Align cards horizontally */
    vertical-align: top; /* Ensure cards stay aligned at the top */
    margin-right: 20px; /* Add spacing between cards */
  }
}

</style>
