<?php

return [

    /*
    |--------------------------------------------------------------------------
    | PDF atskaišu valodas rindas (custom made)
    |--------------------------------------------------------------------------
    |
    | Tālāk norādītās valodas rindas tiek izmantotas PDF atskaitēm,
    | kuriem var piekļūt administratora panelī.
    |
    */

    'generated_at' => 'Izveidots',

    'common' => [
        'na' => '—',
    ],

    'users' => [
        'title' => 'Lietotāju pārskats',

        'total_users' => 'Kopējais lietotāju skaits',
        'active_users' => 'Aktīvo lietotāju skaits',
        'banned_users' => 'Aizliegto lietotāju skaits',
        'deleted_users' => 'Izdzēsto lietotāju skaits',

        'table' => [
            'name' => 'Lietotājvārds',
            'email' => 'E-pasts',
            'roles' => 'Lomas',
            'registered_at' => 'Reģistrācijas datums',
            'status' => 'Konta statuss',
        ],

        'status' => [
            'active' => 'aktīvs',
            'banned' => 'aizliegts',
            'deleted' => 'izdzēsts',
        ],
    ],
];
