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
        Schema::create('lyrics', function (Blueprint $table) {
            $table->id();
            $table->text('lyrics')->nullable();
            $table->enum('status', ['verified', 'requires verification'])->default('requires verification');
            $table->unsignedBigInteger('track_id')->unique();
            $table->unsignedBigInteger('last_updated_by_user')->nullable(); // nullable because of set null restriction
            $table->timestamps();

            // foreign keys
            $table->foreign('track_id')
                ->references('id')
                ->on('tracks')
                ->onDelete('cascade'); // cascade delete

            $table->foreign('last_updated_by_user')
                ->references('id')
                ->on('users')
                ->onDelete('set null'); // set null on delete
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lyrics');
    }
};
