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
        Schema::create('tracks', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->time('duration');
            $table->text('description_en')->nullable();
            $table->text('description_lv')->nullable();
            $table->string('audio_source')->nullable();
            $table->date('release_date');
            $table->double('popularity', 10, 2)->default(0.00);
            $table->timestamps();

            $table->index('popularity');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tracks');
    }
};
