<?php

use App\Models\Genre;

// Function to generate slug from name
function customSlugify(string $name): string
{
    $slug = mb_strtolower($name);
    // replace spaces with dashes
    $slug = preg_replace('/\s+/u', '-', $slug);
    // remove characters that are not letters, numbers, dashes, or underscores
    $slug = preg_replace('/[^\p{L}\p{N}_-]/u', '', $slug);
    return trim($slug, '-');
}

// Function to process genres in batches
function processGenres()
{
    $totalProcessed = 0;
    $batchSize = 100; // Process 100 records at a time

    Genre::whereNull('slug')->orWhere('slug', '')->chunkById($batchSize, function ($genres) use (&$totalProcessed) {
        foreach ($genres as $genre) {
            if (empty($genre->name)) {
                continue;
            }

            $originalSlug = customSlugify($genre->name);
            $slug = $originalSlug;
            $counter = 1;

            // Check for existing slugs excluding the current genre
            while (Genre::where('slug', $slug)
                ->where('id', '!=', $genre->id)
                ->exists()) {
                $slug = "{$originalSlug}-{$counter}";
                $counter++;
            }

            $genre->slug = $slug;
            $genre->save();
            $totalProcessed++;
        }

        echo "Processed {$totalProcessed} genres...\n";
    });

    return $totalProcessed;
}

// Run the script
$startTime = microtime(true);
echo "Starting slug generation for genres...\n";

$processedCount = processGenres();

$duration = round(microtime(true) - $startTime, 2);
echo "Completed! Processed {$processedCount} genres in {$duration} seconds.\n";
