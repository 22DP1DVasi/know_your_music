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
        Schema::create('releases', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->date('release_date');
            $table->text('description_en')->nullable();
            $table->text('description_lv')->nullable();
            $table->enum('release_type', ['album', 'ep', 'single', 'compilation']);
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
        Schema::dropIfExists('releases');
    }
};
