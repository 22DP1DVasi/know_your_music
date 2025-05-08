<template>
    <div class="greeting">
        <p>Enhance your music experience.</p>
        <p>Make new discoveries, learn the background of your favorite music and share your tastes.</p>
    </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@800&display=swap');

.greeting {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width: 60%;
    margin: auto;
    font-size: 2.9rem;
    text-align: center;
    font-family: 'Montserrat', sans-serif;
    color: black;
    padding-top: 5%;
}

.greeting p {
    margin: 2%;
}

@media (max-width: 1363px) {
    .greeting {
        width: 85%;
        font-size: 2.3rem;
    }
}

@media (max-width: 768px) {
    .greeting {
        font-size: 2rem;
    }
}

@media (max-width: 480px) {
    .greeting {
        font-size: 1.5rem;
        width: 85%;
    }
}
</style>
