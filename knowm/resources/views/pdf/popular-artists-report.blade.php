<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
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
            line-height: 1.4;
        }

        .generated-date,
        .generated-time {
            display: block;
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

        .text-left {
            text-align: left;
        }

        .popularity-high {
            color: #059669;
            font-weight: bold;
        }

        .popularity-medium {
            color: #d97706;
            font-weight: bold;
        }

        .popularity-low {
            color: #dc2626;
        }

        .status-active {
            color: #166534;
            font-weight: bold;
        }

        .status-inactive {
            color: #6b7280;
        }

        .favorites-high {
            color: #0c4baa;
            font-weight: bold;
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
                    {{ __('reports.generated_at') }}:
                    <span class="generated-date">
                        {{ $generatedAt->format('Y-m-d') }}
                    </span>
                    <span class="generated-time">
                        {{ $generatedAt->format('H:i:s') }} UTC
                    </span>
                </div>
            </td>
        </tr>
    </table>
</div>

<!-- Title -->
<div class="title">
    {{ __('reports.popular_artists.title') }}
</div>

<!-- Table -->
<table class="main-table">
    <thead>
    <tr>
        <th style="width: 24%;">
            {{ __('reports.popular_artists.table.name') }}
        </th>

        <th style="width: 26%;">
            {{ __('reports.popular_artists.table.top_genres') }}
        </th>

        <th style="width: 14%;" class="center">
            {{ __('reports.popular_artists.table.popularity_score') }}
        </th>

        <th style="width: 14%;" class="center">
            {{ __('reports.popular_artists.table.favorites_count') }}
        </th>

        <th style="width: 12%;" class="center">
            {{ __('reports.popular_artists.table.activity_status') }}
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
            <td class="text-left">
                {{
                    $artist->genres
                        ->pluck('name')
                        ->take(3)
                        ->join(', ')
                        ?: __('reports.common.na')
                }}
            </td>

            <!-- Popularity -->
            <td class="center">
                @php
                    $popularity = $artist->popularity ?? 0;
                @endphp

                @if($popularity >= 70)
                    <span class="popularity-high">
                        {{ number_format($popularity, 2) }}
                    </span>
                @elseif($popularity >= 40)
                    <span class="popularity-medium">
                        {{ number_format($popularity, 2) }}
                    </span>
                @else
                    <span class="popularity-low">
                        {{ number_format($popularity, 2) }}
                    </span>
                @endif
            </td>

            <!-- Favorites -->
            <td class="center">
                @php
                    $favoritesCount = $artist->favorited_by_users_count ?? 0;
                @endphp

                @if($favoritesCount > 0)
                    <span class="favorites-high">
                        {{ number_format($favoritesCount) }}
                    </span>
                @else
                    {{ number_format($favoritesCount) }}
                @endif
            </td>

            <!-- Status -->
            <td class="center">
                @if($artist->is_active)
                    <span class="status-active">
                        {{ __('reports.popular_artists.status.active') }}
                    </span>
                @else
                    <span class="status-inactive">
                        {{ __('reports.popular_artists.status.inactive') }}
                    </span>
                @endif
            </td>
        </tr>
    @endforeach
    </tbody>
</table>

</body>
</html>
