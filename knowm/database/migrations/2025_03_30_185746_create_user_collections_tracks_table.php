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
        Schema::create('user_collections_tracks', function (Blueprint $table) {
            $table->unsignedBigInteger('collection_id');
            $table->unsignedBigInteger('track_id');
            $table->unsignedInteger('track_position');
            $table->timestamps();

            // composite primary key
            $table->primary(['collection_id', 'track_id']);
            // position index for sorting
            $table->index(['collection_id', 'track_position']);

            // foreign keys
            $table->foreign('collection_id')
                ->references('id')
                ->on('user_collections')
                ->onDelete('cascade');

            $table->foreign('track_id')
                ->references('id')
                ->on('tracks')
                ->onDelete('cascade');
        });

        // add position management trigger
        DB::unprepared('
            CREATE TRIGGER set_collection_track_position
            BEFORE INSERT ON user_collections_tracks
            FOR EACH ROW
            BEGIN
                IF NEW.track_position = 0 THEN
                    SET NEW.track_position = (
                        SELECT IFNULL(MAX(track_position), 0) + 1
                        FROM user_collections_tracks
                        WHERE collection_id = NEW.collection_id
                    );
                END IF;
            END
        ');

    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::unprepared('DROP TRIGGER IF EXISTS set_collection_track_position');
        Schema::dropIfExists('user_collections_tracks');
    }
};
