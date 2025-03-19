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
        Schema::create('releases_genres', function (Blueprint $table) {
            // Foreign key columns
            $table->unsignedBigInteger('release_id');
            $table->unsignedBigInteger('genre_id');

            // Explicitly add indexes
            $table->index('release_id');
            $table->index('genre_id');

            // Foreign key constraints
            $table->foreign('release_id')
                ->references('id')
                ->on('releases')
                ->onDelete('cascade'); // Cascade deletes if the release is deleted

            $table->foreign('genre_id')
                ->references('id')
                ->on('genres')
                ->onDelete('cascade'); // Cascade deletes if the genre is deleted

            // Composite primary key
            $table->primary(['release_id', 'genre_id']);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('releases_genres');
    }
};
