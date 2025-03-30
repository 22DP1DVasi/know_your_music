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
        Schema::create('recommendations_genres', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('recommendation_id');
            $table->unsignedBigInteger('genre_id');
            $table->enum('user_rating', ['1', '2', '3', '4', '5', 'not_rated'])->default('not_rated');
            $table->timestamps();

            // ensure uniqueness of genres in each recommendation
            $table->unique(['recommendation_id', 'genre_id']);

            $table->foreign('recommendation_id')
                ->references('id')
                ->on('recommendations')
                ->onDelete('cascade');

            $table->foreign('genre_id')
                ->references('id')
                ->on('genres')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recommendations_genres');
    }
};
