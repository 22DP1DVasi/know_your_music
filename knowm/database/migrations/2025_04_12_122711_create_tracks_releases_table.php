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
        Schema::create('tracks_releases', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('track_id');
            $table->unsignedBigInteger('release_id');
            $table->unsignedInteger('track_position');
            $table->timestamps();

            // explicitly add indexes
            $table->index('release_id');
            $table->index('track_id');

            // composite unique indexes
            $table->unique(['release_id', 'track_position'], 'release_track_order_unique');
            $table->unique(['track_id', 'release_id'], 'track_release_unique');

            // foreign keys
            $table->foreign('release_id')
                ->references('id')
                ->on('releases')
                ->onDelete('cascade');

            $table->foreign('track_id')
                ->references('id')
                ->on('tracks')
                ->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tracks_releases');
    }
};
