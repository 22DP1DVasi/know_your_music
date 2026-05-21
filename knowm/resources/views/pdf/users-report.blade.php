<!DOCTYPE html>
<html lang="lv">
<head>
    <meta charset="utf-8">

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

        .summary-table {
            width: 320px;
            margin: 0 auto 50px auto;
            border-collapse: collapse;
        }

        .summary-table td {
            border: 1px solid #111827;
            padding: 8px 12px;
        }

        .summary-label {
            font-weight: bold;
            background: #f3f4f6;
        }

        .summary-value {
            text-align: center;
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

        .col-name {
            width: 18%;
        }

        .col-email {
            width: 28%;
        }

        .col-roles {
            width: 22%;
        }

        .col-date {
            width: 18%;
        }

        .col-status {
            width: 14%;
        }

        .text-left {
            text-align: left;
        }

        .text-center {
            text-align: center;
        }

        .status-active {
            color: #166534;
            font-weight: bold;
        }

        .status-banned {
            color: #991b1b;
            font-weight: bold;
        }

        .status-deleted {
            color: #6b7280;
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
    Lietotāju pārskats
</div>

<!-- Summary -->
<table class="summary-table">
    <tr>
        <td class="summary-label">
            Kopējais lietotāju skaits:
        </td>

        <td class="summary-value">
            {{ $totalUsers }}
        </td>
    </tr>

    <tr>
        <td class="summary-label">
            Aktīvo lietotāju skaits:
        </td>

        <td class="summary-value">
            {{ $activeUsers }}
        </td>
    </tr>

    <tr>
        <td class="summary-label">
            Aizliegto lietotāju skaits:
        </td>

        <td class="summary-value">
            {{ $bannedUsers }}
        </td>
    </tr>

    <tr>
        <td class="summary-label">
            Izdzēsto lietotāju skaits:
        </td>

        <td class="summary-value">
            {{ $deletedUsers }}
        </td>
    </tr>
</table>

<!-- Main table -->
<table class="main-table">
    <thead>
    <tr>
        <th class="col-name">Lietotājvārds</th>
        <th class="col-email">E-pasts</th>
        <th class="col-roles">Lomas</th>
        <th class="col-date">Reģistrācijas datums</th>
        <th class="col-status">Konta statuss</th>
    </tr>
    </thead>

    <tbody>
    @foreach($users as $user)
        <tr>
            <td>
                {{ $user->name }}
            </td>

            <td>
                {{ $user->email }}
            </td>

            @php
                $roles = $user->roles->pluck('name')->join(', ');
                $hasRoles = !empty($roles);
            @endphp

            <td class="{{ $hasRoles ? 'text-left' : 'text-center' }}">
                {{ $roles ?: '—' }}
            </td>

            <td>
                {{ $user->created_at?->format('Y-m-d') ?? 'N/A' }}
            </td>

            <td>
                @if($user->deleted_at)
                    <span class="status-deleted">
                                izdzēsts
                            </span>
                @elseif($user->status === 'banned')
                    <span class="status-banned">
                                aizliegts
                            </span>
                @else
                    <span class="status-active">
                                aktīvs
                            </span>
                @endif
            </td>
        </tr>
    @endforeach
    </tbody>
</table>

</body>
</html>
