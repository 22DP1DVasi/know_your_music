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
        Schema::create('release_genres', function (Blueprint $table) {
            // foreign keys
            $table->unsignedBigInteger('release_id');
            $table->unsignedBigInteger('genre_id');
            $table->timestamps();

            // composite primary key
            $table->primary(['release_id', 'genre_id']);

            // foreign key constraints
            $table->foreign('release_id')
                ->references('id')
                ->on('releases')
                ->onDelete('cascade'); // cascade deletes if the release is deleted

            $table->foreign('genre_id')
                ->references('id')
                ->on('genres')
                ->onDelete('cascade'); // cascade deletes if the genre is deleted
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('release_genres');
    }
};
