<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Validācijas valodas rindas
    |--------------------------------------------------------------------------
    |
    | Šajās valodas rindās ir iekļauti noklusējuma kļūdu paziņojumi, ko izmanto
    | validācijas klase. Dažiem noteikumiem ir vairākas versijas,
    | piemēram, izmēra (size) noteikumiem. Jūs varat brīvi pielāgot
    | katru no šiem paziņojumiem.
    |
    */

    'accepted' => 'Lauks :attribute ir jāapstiprina.',
    'accepted_if' => 'Lauks :attribute ir jāapstiprina, ja :other ir :value.',
    'active_url' => 'Laukam :attribute ir jābūt derīgai URL adresei.',
    'after' => 'Laukam :attribute ir jābūt datumam pēc :date.',
    'after_or_equal' => 'Laukam :attribute ir jābūt datumam pēc vai vienādam ar :date.',
    'alpha' => 'Lauks :attribute drīkst saturēt tikai burtus.',
    'alpha_dash' => 'Lauks :attribute drīkst saturēt tikai burtus, ciparus, domuzīmes un pasvītrojumus.',
    'alpha_num' => 'Lauks :attribute drīkst saturēt tikai burtus un ciparus.',
    'array' => 'Laukam :attribute ir jābūt masīvam.',
    'ascii' => 'Lauks :attribute drīkst saturēt tikai viena baita burtciparu rakstzīmes un simbolus.',
    'before' => 'Laukam :attribute ir jābūt datumam pirms :date.',
    'before_or_equal' => 'Laukam :attribute ir jābūt datumam pirms vai vienādam ar :date.',

    'between' => [
        'array' => 'Laukā :attribute jābūt no :min līdz :max elementiem.',
        'file' => 'Faila :attribute izmēram jābūt no :min līdz :max kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt no :min līdz :max.',
        'string' => 'Laukam :attribute jābūt no :min līdz :max rakstzīmēm.',
    ],

    'boolean' => 'Laukam :attribute ir jābūt patiesai vai aplamai vērtībai.',
    'can' => 'Lauks :attribute satur neatļautu vērtību.',
    'confirmed' => 'Lauka :attribute apstiprinājums nesakrīt.',
    'contains' => 'Laukā :attribute trūkst nepieciešamā vērtība.',
    'current_password' => 'Parole nav pareiza.',
    'date' => 'Laukam :attribute ir jābūt derīgam datumam.',
    'date_equals' => 'Laukam :attribute ir jābūt datumam, kas vienāds ar :date.',
    'date_format' => 'Laukam :attribute jāatbilst formātam :format.',
    'decimal' => 'Laukam :attribute jābūt ar :decimal zīmēm aiz komata.',
    'declined' => 'Lauks :attribute ir jānoraida.',
    'declined_if' => 'Lauks :attribute ir jānoraida, ja :other ir :value.',
    'different' => 'Laukiem :attribute un :other ir jābūt atšķirīgiem.',
    'digits' => 'Laukam :attribute jābūt :digits cipariem.',
    'digits_between' => 'Laukam :attribute jābūt no :min līdz :max cipariem.',
    'dimensions' => 'Laukam :attribute ir neatbilstoši attēla izmēri.',
    'distinct' => 'Laukam :attribute ir dublikāta vērtība.',
    'doesnt_end_with' => 'Lauks :attribute nedrīkst beigties ar kādu no šīm vērtībām: :values.',
    'doesnt_start_with' => 'Lauks :attribute nedrīkst sākties ar kādu no šīm vērtībām: :values.',
    'email' => 'Laukam :attribute ir jābūt derīgai e-pasta adresei.',
    'ends_with' => 'Laukam :attribute jābeidzas ar kādu no šīm vērtībām: :values.',
    'enum' => 'Izvēlētais :attribute nav derīgs.',
    'exists' => 'Izvēlētais :attribute nav derīgs.',
    'extensions' => 'Laukam :attribute jābūt ar kādu no šiem paplašinājumiem: :values.',
    'file' => 'Laukam :attribute ir jābūt failam.',
    'filled' => 'Laukam :attribute ir jābūt aizpildītam.',

    'gt' => [
        'array' => 'Laukā :attribute jābūt vairāk nekā :value elementiem.',
        'file' => 'Failam :attribute jābūt lielākam par :value kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt lielākai par :value.',
        'string' => 'Laukam :attribute jābūt garākam par :value rakstzīmēm.',
    ],

    'gte' => [
        'array' => 'Laukā :attribute jābūt vismaz :value elementiem.',
        'file' => 'Failam :attribute jābūt lielākam vai vienādam ar :value kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt lielākai vai vienādai ar :value.',
        'string' => 'Laukam :attribute jābūt vismaz :value rakstzīmēm.',
    ],

    'hex_color' => 'Laukam :attribute ir jābūt derīgai heksadecimālai krāsai.',
    'image' => 'Laukam :attribute ir jābūt attēlam.',
    'in' => 'Izvēlētais :attribute nav derīgs.',
    'in_array' => 'Laukam :attribute ir jāeksistē laukā :other.',
    'integer' => 'Laukam :attribute ir jābūt veselam skaitlim.',
    'ip' => 'Laukam :attribute ir jābūt derīgai IP adresei.',
    'ipv4' => 'Laukam :attribute ir jābūt derīgai IPv4 adresei.',
    'ipv6' => 'Laukam :attribute ir jābūt derīgai IPv6 adresei.',
    'json' => 'Laukam :attribute ir jābūt derīgai JSON virknei.',
    'list' => 'Laukam :attribute ir jābūt sarakstam.',
    'lowercase' => 'Laukam :attribute jābūt rakstītam ar mazajiem burtiem.',

    'lt' => [
        'array' => 'Laukā :attribute jābūt mazāk nekā :value elementiem.',
        'file' => 'Failam :attribute jābūt mazākam par :value kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt mazākai par :value.',
        'string' => 'Laukam :attribute jābūt īsākam par :value rakstzīmēm.',
    ],

    'lte' => [
        'array' => 'Laukā :attribute nedrīkst būt vairāk par :value elementiem.',
        'file' => 'Failam :attribute jābūt mazākam vai vienādam ar :value kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt mazākai vai vienādai ar :value.',
        'string' => 'Laukam :attribute jābūt ne garākam par :value rakstzīmēm.',
    ],

    'mac_address' => 'Laukam :attribute ir jābūt derīgai MAC adresei.',

    'max' => [
        'array' => 'Laukā :attribute nedrīkst būt vairāk par :max elementiem.',
        'file' => 'Faila :attribute izmērs nedrīkst pārsniegt :max kilobaitus.',
        'numeric' => 'Lauka :attribute vērtība nedrīkst pārsniegt :max.',
        'string' => 'Laukam :attribute nedrīkst būt vairāk par :max rakstzīmēm.',
    ],

    'max_digits' => 'Laukam :attribute nedrīkst būt vairāk par :max cipariem.',
    'mimes' => 'Laukam :attribute jābūt failam ar tipu: :values.',
    'mimetypes' => 'Laukam :attribute jābūt failam ar tipu: :values.',

    'min' => [
        'array' => 'Laukā :attribute jābūt vismaz :min elementiem.',
        'file' => 'Failam :attribute jābūt vismaz :min kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt vismaz :min.',
        'string' => 'Laukam :attribute jābūt vismaz :min rakstzīmēm.',
    ],

    'min_digits' => 'Laukam :attribute jābūt vismaz :min cipariem.',
    'missing' => 'Lauks :attribute nedrīkst būt klāt.',
    'missing_if' => 'Lauks :attribute nedrīkst būt klāt, ja :other ir :value.',
    'missing_unless' => 'Lauks :attribute nedrīkst būt klāt, ja vien :other nav :value.',
    'missing_with' => 'Lauks :attribute nedrīkst būt klāt, ja ir norādīts :values.',
    'missing_with_all' => 'Lauks :attribute nedrīkst būt klāt, ja ir norādīti :values.',
    'multiple_of' => 'Lauka :attribute vērtībai jābūt :value daudzkārtnei.',
    'not_in' => 'Izvēlētais :attribute nav derīgs.',
    'not_regex' => 'Lauka :attribute formāts nav derīgs.',
    'numeric' => 'Laukam :attribute ir jābūt skaitlim.',

    'password' => [
        'letters' => 'Laukam :attribute jāsatur vismaz viens burts.',
        'mixed' => 'Laukam :attribute jāsatur vismaz viens lielais un viens mazais burts.',
        'numbers' => 'Laukam :attribute jāsatur vismaz viens cipars.',
        'symbols' => 'Laukam :attribute jāsatur vismaz viens simbols.',
        'uncompromised' => 'Norādītais :attribute ir konstatēts datu noplūdē. Lūdzu, izvēlieties citu :attribute.',
    ],

    'present' => 'Laukam :attribute ir jābūt klātesošam.',
    'present_if' => 'Laukam :attribute ir jābūt klātesošam, ja :other ir :value.',
    'present_unless' => 'Laukam :attribute ir jābūt klātesošam, ja vien :other nav :value.',
    'present_with' => 'Laukam :attribute ir jābūt klātesošam, ja ir norādīts :values.',
    'present_with_all' => 'Laukam :attribute ir jābūt klātesošam, ja ir norādīti :values.',
    'prohibited' => 'Lauks :attribute ir aizliegts.',
    'prohibited_if' => 'Lauks :attribute ir aizliegts, ja :other ir :value.',
    'prohibited_unless' => 'Lauks :attribute ir aizliegts, ja vien :other nav :values.',
    'prohibits' => 'Lauks :attribute aizliedz lauka :other klātbūtni.',
    'regex' => 'Lauka :attribute formāts nav derīgs.',
    'required' => 'Lauks :attribute ir obligāts.',
    'required_array_keys' => 'Laukā :attribute jābūt ierakstiem: :values.',
    'required_if' => 'Lauks :attribute ir obligāts, ja :other ir :value.',
    'required_if_accepted' => 'Lauks :attribute ir obligāts, ja :other ir apstiprināts.',
    'required_if_declined' => 'Lauks :attribute ir obligāts, ja :other ir noraidīts.',
    'required_unless' => 'Lauks :attribute ir obligāts, ja vien :other nav :values.',
    'required_with' => 'Lauks :attribute ir obligāts, ja ir norādīts :values.',
    'required_with_all' => 'Lauks :attribute ir obligāts, ja ir norādīti :values.',
    'required_without' => 'Lauks :attribute ir obligāts, ja :values nav norādīts.',
    'required_without_all' => 'Lauks :attribute ir obligāts, ja nav norādīts neviens no :values.',
    'same' => 'Laukam :attribute jāsakrīt ar :other.',

    'size' => [
        'array' => 'Laukā :attribute jābūt :size elementiem.',
        'file' => 'Failam :attribute jābūt :size kilobaitiem.',
        'numeric' => 'Lauka :attribute vērtībai jābūt :size.',
        'string' => 'Laukam :attribute jābūt :size rakstzīmēm.',
    ],

    'starts_with' => 'Lauks :attribute jāsākas ar kādu no šīm vērtībām: :values.',
    'string' => 'Laukam :attribute ir jābūt teksta virknei.',
    'timezone' => 'Laukam :attribute ir jābūt derīgai laika joslai.',
    'unique' => 'Šāda :attribute vērtība jau pastāv.',
    'uploaded' => 'Neizdevās augšupielādēt :attribute.',
    'uppercase' => 'Laukam :attribute jābūt rakstītam ar lielajiem burtiem.',
    'url' => 'Laukam :attribute ir jābūt derīgai URL adresei.',
    'ulid' => 'Laukam :attribute ir jābūt derīgam ULID.',
    'uuid' => 'Laukam :attribute ir jābūt derīgam UUID.',

    /*
    |--------------------------------------------------------------------------
    | Pielāgotas validācijas valodas rindas
    |--------------------------------------------------------------------------
    |
    | Šeit varat norādīt pielāgotus validācijas paziņojumus konkrētiem
    | atribūtiem, izmantojot formātu "atribūts.noteikums".
    | Tas ļauj ātri definēt specifisku paziņojumu konkrētam laukam.
    |
    */

    'custom' => [
        'attribute-name' => [
            'rule-name' => 'pielāgots-paziņojums',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Pielāgoti validācijas atribūti
    |--------------------------------------------------------------------------
    |
    | Šīs valodas rindas tiek izmantotas, lai aizstātu atribūta vietturi
    | ar lietotājam draudzīgāku nosaukumu, piemēram, "E-pasta adrese"
    | lauka "email" vietā.
    |
    */

    'attributes' => [],

];
