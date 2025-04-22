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
        Schema::create('comments_tracks', function (Blueprint $table) {
            $table->id();
            // polymorphic relationship
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('track_id');
            $table->text('text');
            $table->enum('status', ['visible', 'hidden', 'deleted'])->default('visible');
            $table->string('deleted_username', 100)->nullable();   // store username before user deletion as metadata
            $table->timestamps();

            // explicit indexes
            $table->index('user_id');
            $table->index('track_id');
            $table->index('status'); // for better performance

            // foreign keys
            $table->foreign('user_id')
                ->references('id')
                ->on('users')
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
        Schema::dropIfExists('comments_tracks');
    }
};
