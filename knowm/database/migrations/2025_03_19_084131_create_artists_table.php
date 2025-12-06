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
        Schema::create('artists', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug')->unique();
            $table->text('biography')->nullable();
            $table->text('biography_lv')->nullable();
            $table->unsignedSmallInteger('formed_year')->nullable();
            $table->unsignedSmallInteger('disbanded_year')->nullable();
            $table->boolean('is_active');
            $table->enum('solo_or_band', ['solo', 'band'])->nullable();
            $table->double('popularity', 10, 2)->default(0.00);
            $table->timestamps();

            $table->index('popularity');
            $table->index('is_active');
            $table->index('solo_or_band');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('artists');
    }
};
