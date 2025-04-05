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
            // polymorphic relationship
            $table->unsignedBigInteger('commenter_id')->nullable();
            $table->string('commenter_type')->nullable();    // will store 'App\Models\User' or 'App\Models\Admin'
            $table->unsignedBigInteger('artist_id');
            $table->text('text');
            $table->enum('status', ['visible', 'hidden', 'deleted'])->default('visible');
            $table->string('deleted_username', 100)->nullable(); // store username before user deletion as metadata
            $table->timestamps();

            // indexes
            $table->index(['commenter_id', 'commenter_type']); // Composite index for polymorphic relation
            $table->index('artist_id');
            $table->index('status'); // for better performance

            // foreign keys
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
        Schema::dropIfExists('comments_artists');
    }
};
