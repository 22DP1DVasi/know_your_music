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
        Schema::create('artists_releases', function (Blueprint $table) {
            $table->unsignedBigInteger('artist_id');
            $table->unsignedBigInteger('release_id');
            // role field with enum options
            $table->enum('role', ['primary', 'featured', 'producer'])->default('primary');

            // explicitly add indexes
            $table->index('artist_id');
            $table->index('release_id');

            // composite primary key
            $table->primary(['artist_id', 'release_id']);

            $table->foreign('artist_id')
                ->references('id')
                ->on('artists')
                ->onDelete('cascade');

            $table->foreign('release_id')
                ->references('id')
                ->on('releases')
                ->onDelete('cascade');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('artists_releases');
    }
};
