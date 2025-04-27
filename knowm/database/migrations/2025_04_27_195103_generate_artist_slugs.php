<?php

use App\Models\Artist;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

return new class extends Migration
{
    public function up()
    {
        // Add slug column if it doesn't exist
        if (!Schema::hasColumn('artists', 'slug')) {
            Schema::table('artists', function (Blueprint $table) {
                $table->string('slug')->nullable()->after('name');
            });
        }

        // Generate slugs for all artists
        Artist::chunkById(100, function ($artists) {
            foreach ($artists as $artist) {
                $this->generateAndSetSlug($artist);
            }
        });

        // Make slug column unique and not nullable
        Schema::table('artists', function (Blueprint $table) {
            $table->string('slug')->nullable(false)->unique()->change();
        });
    }

    private function generateAndSetSlug(Artist $artist)
    {
        $originalSlug = $this->customSlugify($artist->name);
        $slug = $originalSlug;
        $counter = 1;

        // Check for existing slugs and append counter if needed
        while (Artist::where('slug', $slug)->where('id', '!=', $artist->id)->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }

        $artist->slug = $slug;
        $artist->save();
    }

    private function customSlugify(string $name): string
    {
        // Preserve special characters and Cyrillic letters
        $slug = mb_strtolower($name);

        // Replace spaces with dashes
        $slug = preg_replace('/\s+/u', '-', $slug);

        // Remove characters that are not letters, numbers, dashes, or underscores
        // Note: The hyphen is moved to the end of the character class
        $slug = preg_replace('/[^\p{L}\p{N}_-]/u', '', $slug);

        // Remove leading/trailing dashes
        return trim($slug, '-');
    }

    public function down()
    {
        Schema::table('artists', function (Blueprint $table) {
            $table->dropColumn('slug');
        });
    }
};
