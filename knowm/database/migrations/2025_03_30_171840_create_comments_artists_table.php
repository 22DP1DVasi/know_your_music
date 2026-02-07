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
        Schema::create('comments_artists', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('artist_id');
            $table->text('text');
            $table->enum('status', ['visible', 'hidden', 'deleted'])->default('visible');
            $table->string('deleted_username', 100)->nullable(); // saglabāt lietotājvārdu pirms lietotāja dzēšanas kā metadatus
            $table->enum('deleted_by', ['author', 'moderator', 'system'])
                ->nullable();
            $table->enum('delete_reason', ['self_deleted', 'spam', 'abuse', 'off_topic', 'other'])
                ->nullable();
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->timestamps();
            $table->timestamp('edited_at')->nullable();

            $table->softDeletes();

            $table->index('user_id');
            $table->index('artist_id');
            $table->index('parent_id');
            $table->index('deleted_by');
            $table->index('delete_reason');
            $table->index('edited_at');

            $table->foreign('user_id')
                ->references('id')
                ->on('users')
                ->onDelete('restrict');

            $table->foreign('artist_id')
                ->references('id')
                ->on('artists')
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
        Schema::dropIfExists('comments_artists');
    }
};
