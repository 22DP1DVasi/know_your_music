<?php

use App\Models\Track;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

return new class extends Migration
{
    public function up()
    {
        if (!Schema::hasColumn('tracks', 'slug')) {
            Schema::table('tracks', function (Blueprint $table) {
                $table->string('slug')->nullable()->after('title');
            });
        }
        Track::chunkById(100, function ($tracks) {
            foreach ($tracks as $track) {
                $this->generateAndSetSlug($track);
            }
        });
//        Schema::table('tracks', function (Blueprint $table) {
//            $table->string('slug')->nullable(false)->unique()->change();
//        });
    }

    private function generateAndSetSlug(Track $track)
    {
        $originalSlug = $this->customSlugify($track->title);
        $slug = $originalSlug;
        $counter = 1;
        while (Track::where('slug', $slug)->where('id', '!=', $track->id)->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }
        $track->slug = $slug;
        $track->save();
    }

    private function customSlugify(string $title): string
    {
        $slug = mb_strtolower($title);
        // replace spaces with dashes
        $slug = preg_replace('/\s+/u', '-', $slug);
        // remove characters that are not letters, numbers, dashes, or underscores
        $slug = preg_replace('/[^\p{L}\p{N}_-]/u', '', $slug);
        return trim($slug, '-');
    }

    public function down()
    {
        Schema::table('tracks', function (Blueprint $table) {
            $table->dropColumn('slug');
        });
    }
};
