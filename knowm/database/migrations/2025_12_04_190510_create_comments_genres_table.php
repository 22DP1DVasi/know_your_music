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
        Schema::create('comments_genres', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->nullable();
            $table->unsignedBigInteger('genre_id');
            $table->text('text');
            $table->enum('status', ['visible', 'hidden', 'deleted'])->default('visible');
            $table->string('deleted_username', 100)->nullable(); // saglabāt lietotājvārdu pirms lietotāja dzēšanas kā metadatus
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->timestamps();
            $table->timestamp('edited_at')->nullable();

            $table->index('user_id');
            $table->index('genre_id');
            $table->index('parent_id');
            $table->index('edited_at');

            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->onDelete('restrict');

            $table->foreign('genre_id')
                ->references('id')
                ->on('genres')
                ->onDelete('cascade');

            $table->foreign('parent_id')
                ->references('id')
                ->on('comments_artists')
                ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comments_genres');
    }
};
