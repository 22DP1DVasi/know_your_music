<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('recommendations_artists', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('recommendation_genre_id');
            $table->unsignedBigInteger('artist_id');
            $table->timestamps();

            // ensure uniqueness for each artist in the genre group
            $table->unique(['recommendation_genre_id', 'artist_id']);

            // foreign keys
            $table->foreign('recommendation_genre_id')
                ->references('id')
                ->on('recommendations_genres')
                ->onDelete('cascade');

            $table->foreign('artist_id')
                ->references('id')
                ->on('artists')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recommendations_artists');
    }
};
