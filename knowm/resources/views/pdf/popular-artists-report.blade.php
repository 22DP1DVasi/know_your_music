<!DOCTYPE html>
<html lang="lv">
<head>
    <meta charset="UTF-8">

    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            color: #111827;
        }

        .header {
            width: 100%;
            margin-bottom: 30px;
        }

        .header-table {
            width: 100%;
        }

        .logo-cell {
            text-align: right;
            vertical-align: top;
            width: 140px;
        }

        .logo {
            width: 90px;
        }

        .generated-at {
            margin-top: 10px;
            font-size: 11px;
            color: #374151;
        }

        .title {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .main-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .main-table th,
        .main-table td {
            border: 1px solid #374151;
            padding: 8px;
            word-wrap: break-word;
            overflow-wrap: break-word;
            vertical-align: top;
        }

        .main-table th {
            background: #e5e7eb;
            font-weight: bold;
        }

        .center {
            text-align: center;
        }
    </style>
</head>

<body>

<!-- Header -->
<div class="header">
    <table class="header-table">
        <tr>
            <td></td>

            <td class="logo-cell">
                <img
                    src="{{ public_path('images/mini-logo.png') }}"
                    class="logo"
                    alt="Logo"
                >

                <div class="generated-at">
                    Izveidots:
                    {{ $generatedAt->format('Y-m-d H:i:s') }} UTC
                </div>
            </td>
        </tr>
    </table>
</div>

<!-- Title -->
<div class="title">
    Populārāko mūzikas izpildītāju pārskats
</div>

<!-- Table -->
<table class="main-table">
    <thead>
    <tr>
        <th style="width: 24%;">
            Nosaukums
        </th>

        <th style="width: 26%;">
            Pirmie 3 žanri
        </th>

        <th style="width: 14%;" class="center">
            Popularitātes indekss
        </th>

        <th style="width: 14%;" class="center">
            Saglabājumu skaits
        </th>

        <th style="width: 12%;" class="center">
            Aktivitātes statuss
        </th>
    </tr>
    </thead>

    <tbody>
    @foreach ($artists as $artist)
        <tr>
            <!-- Name -->
            <td>
                {{ $artist->name }}
            </td>

            <!-- Genres -->
            <td>
                {{
                    $artist->genres
                        ->pluck('name')
                        ->take(3)
                        ->join(', ')
                        ?: '—'
                }}
            </td>

            <!-- Popularity -->
            <td class="center">
                {{ number_format($artist->popularity, 2) }}
            </td>

            <!-- Favorites -->
            <td class="center">
                {{ $artist->favorited_by_users_count }}
            </td>

            <!-- Status -->
            <td class="center">
                {{
                    $artist->is_active
                        ? 'aktīvs'
                        : 'neaktīvs'
                }}
            </td>
        </tr>
    @endforeach
    </tbody>
</table>

</body>
</html>
