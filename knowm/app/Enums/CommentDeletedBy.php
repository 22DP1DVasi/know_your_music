<?php

namespace App\Enums;

enum CommentDeletedBy: string
{
    case Author = 'author';
    case Moderator = 'moderator';
    case System = 'system';

    public function label(): string
    {
        return match ($this) {
            self::Author => 'author',
            self::Moderator => 'moderator',
            self::System => 'system',
        };
    }
}
