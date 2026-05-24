<?php

return [

    /*
    |--------------------------------------------------------------------------
    | PDF Reports Language Files (custom made)
    |--------------------------------------------------------------------------
    |
    | The following language lines are used for PDF reports accessed
    | in the admin panel.
    |
    */

    'generated_at' => 'Generated at',

    'common' => [
        'na' => '—',
    ],

    'users' => [
        'title' => 'Users Report',

        'total_users' => 'Total number of users',
        'active_users' => 'Number of active users',
        'banned_users' => 'Number of banned users',
        'deleted_users' => 'Number of deleted users',

        'table' => [
            'name' => 'Username',
            'email' => 'Email',
            'roles' => 'Roles',
            'registered_at' => 'Registration date',
            'status' => 'Account status',
        ],

        'status' => [
            'active' => 'active',
            'banned' => 'banned',
            'deleted' => 'deleted',
        ],
    ],

    'comments' => [
        'title' => 'Comments Report',

        'table' => [
            'id' => 'ID',
            'author' => 'Author username',
            'text' => 'Text',
            'status' => 'Status',
            'published_at' => 'Published at',
            'object' => 'Object',
            'reply_to' => 'Reply to',
        ],

        'status' => [
            'visible' => 'visible',
            'hidden' => 'hidden',
            'deleted' => 'deleted',
        ],

        'entity' => [
            'artist' => 'Artist',
            'release' => 'Release',
            'track' => 'Track',
            'genre' => 'Genre',
        ],
    ],
];
