<?php

use App\Models\Release;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

return new class extends Migration
{
    public function up()
    {
        if (!Schema::hasColumn('releases', 'slug')) {
            Schema::table('releases', function (Blueprint $table) {
                $table->string('slug')->nullable()->after('title');
            });
        }
        Release::chunkById(100, function ($releases) {
            foreach ($releases as $release) {
                $this->generateAndSetSlug($release);
            }
        });
        Schema::table('releases', function (Blueprint $table) {
            $table->string('slug')->nullable(false)->unique()->change();
        });
    }

    private function generateAndSetSlug(Release $release)
    {
        $originalSlug = $this->customSlugify($release->title);
        $slug = $originalSlug;
        $counter = 1;
        while (Release::where('slug', $slug)->where('id', '!=', $release->id)->exists()) {
            $slug = "{$originalSlug}-{$counter}";
            $counter++;
        }
        $release->slug = $slug;
        $release->save();
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
        Schema::table('releases', function (Blueprint $table) {
            $table->dropColumn('slug');
        });
    }
};
