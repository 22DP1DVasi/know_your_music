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

        .status-visible {
            color: #166534;
            font-weight: bold;
        }

        .status-hidden {
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
                    {{ __('reports.generated_at') }}:
                    {{ $generatedAt->format('Y-m-d H:i:s') }} UTC
                </div>
            </td>
        </tr>
    </table>
</div>

<!-- Title -->
<div class="title">
    {{ __('reports.comments.title') }}
</div>

<!-- Main table -->
<table class="main-table">
    <thead>
    <tr>
        <th style="width: 5%">{{ __('reports.comments.table.id') }}</th>
        <th style="width: 13%">{{ __('reports.comments.table.author') }}</th>
        <th style="width: 28%">{{ __('reports.comments.table.text') }}</th>
        <th style="width: 10%">{{ __('reports.comments.table.status') }}</th>
        <th style="width: 14%">{{ __('reports.comments.table.published_at') }}</th>
        <th style="width: 20%">{{ __('reports.comments.table.object') }}</th>
        <th style="width: 10%">{{ __('reports.comments.table.reply_to') }}</th>
    </tr>
    </thead>

    <tbody>
    @foreach($comments as $comment)
        <tr>
            <td class="center">
                {{ $comment['id'] }}
            </td>

            <td>
                {{ $comment['author'] }}
            </td>

            <td>
                {{ $comment['text'] }}
            </td>

            <td class="center">
                @php
                    $status = $comment['status'];
                    $allowed = ['visible', 'hidden', 'deleted'];
                @endphp

                @if(in_array($status, $allowed))
                    <span class="status-{{ $status }}">
                        {{ __("reports.comments.status.$status") }}
                    </span>
                @else
                    {{ $status }}
                @endif
            </td>

            <td class="center">
                {{ $comment['created_at']->format('Y-m-d H:i:s') }}
            </td>

            <td>
                {{ $comment['object'] }}
            </td>

            <td class="center">
                {{ $comment['parent_id'] ?? __('reports.common.na') }}
            </td>
        </tr>
    @endforeach
    </tbody>
</table>

</body>
</html>
