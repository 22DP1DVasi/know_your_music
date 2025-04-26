<?php

namespace App\Console\Commands;

use App\Models\Artist;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;

class SetupArtistFolders extends Command
{
    protected $signature = 'artists:setup-folders
                            {--limit= : Maximum number of artists to process}
                            {--force : Skip confirmation}';

    protected $description = 'Create image folders for artists';

    public function handle()
    {
        $limit = $this->option('limit');
        $artists = Artist::when($limit, fn($q) => $q->limit($limit))->get();
        if (!$this->option('force') && !$this->confirm(
                "This will create folders for {$artists->count()} artists. Continue?", true
            )) {
            return;
        }
        $bar = $this->output->createProgressBar($artists->count());
        $bar->start();
        $created = 0;
        $skipped = 0;
        foreach ($artists as $artist) {
            $paths = [
                "artists/{$artist->id}/profile",
                "artists/{$artist->id}/banner"
            ];
            foreach ($paths as $path) {
                if (!Storage::disk('public')->exists($path)) {
                    Storage::disk('public')->makeDirectory($path);
                    $created++;
                } else {
                    $skipped++;
                }
            }
            $bar->advance();
        }
        $bar->finish();
        $this->newLine(2);
        $this->info("Operation complete!");
        $this->line("Created folders: {$created}");
        $this->line("Skipped existing: {$skipped}");
        $this->line("Total artists processed: {$artists->count()}");
    }
}
