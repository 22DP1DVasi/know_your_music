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
        if (!Schema::hasColumn('artists', 'slug')) {
            Schema::table('artists', function (Blueprint $table) {
                $table->string('slug')->nullable()->after('name');
            });
        }
        Artist::chunkById(100, function ($artists) {
            foreach ($artists as $artist) {
                $this->generateAndSetSlug($artist);
            }
        });
//        Schema::table('artists', function (Blueprint $table) {
//            $table->string('slug')->nullable(false)->unique()->change();
//        });
    }

    private function generateAndSetSlug(Artist $artist)
    {
        $originalSlug = $this->customSlugify($artist->name);
        $slug = $originalSlug;
        $counter = 1;
        while (Artist::where('slug', $slug)->where('id', '!=', $artist->id)->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }
        $artist->slug = $slug;
        $artist->save();
    }

    private function customSlugify(string $name): string
    {
        $slug = mb_strtolower($name);
        // replace spaces with dashes
        $slug = preg_replace('/\s+/u', '-', $slug);
        // remove characters that are not letters, numbers, dashes, or underscores
        $slug = preg_replace('/[^\p{L}\p{N}]+/u', '-', $slug);
        return trim($slug, '-');
    }

    public function down()
    {
        Schema::table('artists', function (Blueprint $table) {
            $table->dropColumn('slug');
        });
    }
};
