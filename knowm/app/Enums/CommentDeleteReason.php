<?php

namespace App\Enums;

enum CommentDeleteReason: string
{
    case SelfDeleted = 'self_deleted';
    case Spam = 'spam';
    case Abuse = 'abuse';
    case OffTopic = 'off_topic';
    case Other = 'other';

    public function label(): string
    {
        return match ($this) {
            self::Spam => 'Spam',
            self::Abuse => 'Abusive content',
            self::OffTopic => 'Off topic',
            self::SelfDeleted => 'Deleted by author',
            self::Other => 'Other reason',
        };
    }
}
