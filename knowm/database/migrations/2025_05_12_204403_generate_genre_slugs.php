<?php

use App\Models\Genre;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;
use Illuminate\Database\Schema\Blueprint;

return new class extends Migration
{
    public function up()
    {
        if (!Schema::hasColumn('genres', 'slug')) {
            Schema::table('genres', function ($table) {
                $table->string('slug', 120)->nullable()->after('name');
            });
        }
        Genre::chunkById(100, function ($genres) {
            foreach ($genres as $genre) {
                $this->generateAndSetSlug($genre);
            }
        });

        // Schema::table('genres', function (Blueprint $table) {
        //     $table->string('slug', 120)->nullable(false)->unique()->change();
        // });
    }

    private function generateAndSetSlug(Genre $genre)
    {
        if (empty($genre->name)) {
            return;
        }
        $originalSlug = $this->customSlugify($genre->name);
        $slug = $originalSlug;
        $counter = 1;
        while (Genre::where('slug', $slug)->where('id', '!=', $genre->id)->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }
        $genre->slug = $slug;
        $genre->save();
    }

    private function customSlugify(string $name): string
    {
        $slug = mb_strtolower($name);
        // replace spaces with dashes
        $slug = preg_replace('/\s+/u', '-', $slug);
        // remove characters that are not letters, numbers, dashes, or underscores
        $slug = preg_replace('/[^\p{L}\p{N}_-]/u', '', $slug);
        return trim($slug, '-');
    }

    public function down()
    {
        Schema::table('genres', function (Blueprint $table) {
            $table->dropColumn('slug');
        });
    }
};
