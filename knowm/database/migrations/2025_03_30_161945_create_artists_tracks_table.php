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
        Schema::create('artists_tracks', function (Blueprint $table) {
            $table->unsignedBigInteger('artist_id');
            $table->unsignedBigInteger('track_id');
            // role field with enum options
            $table->enum('role', ['primary', 'featured', 'producer'])->default('primary');
            $table->timestamps();

            // explicitly add indexes
            $table->index('artist_id');
            $table->index('track_id');

            // indexes for better performance
            $table->index(['artist_id', 'role']);
            $table->index(['track_id', 'role']);

            // composite primary key
            $table->primary(['artist_id', 'track_id']);

            // foreign keys
            $table->foreign('artist_id')
                ->references('id')
                ->on('artists')
                ->onDelete('cascade');

            $table->foreign('track_id')
                ->references('id')
                ->on('tracks')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('artists_tracks');
    }
};
