<!DOCTYPE html>
<html lang="lv">
<head>
    <meta charset="UTF-8">

    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            color: #111;
        }

        .header {
            width: 100%;
            margin-bottom: 30px;
        }

        .logo {
            text-align: right;
        }

        .logo img {
            width: 90px;
        }

        .generated-at {
            text-align: right;
            margin-top: 10px;
            font-size: 11px;
        }

        .title {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            margin: 30px 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th,
        td {
            border: 1px solid #444;
            padding: 8px;
            vertical-align: top;
            word-wrap: break-word;
        }

        th {
            background: #d9d9d9;
            text-align: center;
        }

        .center {
            text-align: center;
        }

        .small {
            font-size: 11px;
        }
    </style>
</head>
<body>

<div class="header">
    <div class="logo">
        <img
            src="{{ public_path('images/mini-logo.png') }}"
            alt="Logo"
        >
    </div>

    <div class="generated-at">
        Izveidots:
        {{ $generatedAt->format('Y-m-d H:i:s') }}
    </div>
</div>

<div class="title">
    Komentāru pārskats
</div>

<table>
    <thead>
    <tr>
        <th style="width: 5%">ID</th>
        <th style="width: 13%">Autora lietotājvārds</th>
        <th style="width: 28%">Teksts</th>
        <th style="width: 10%">Statuss</th>
        <th style="width: 14%">Publicēšanas laiks</th>
        <th style="width: 20%">Objekts</th>
        <th style="width: 10%">Atbilde uz</th>
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
                {{ $comment['status'] }}
            </td>

            <td class="center">
                {{ $comment['created_at']->format('Y-m-d H:i:s') }}
            </td>

            <td>
                {{ $comment['object'] }}
            </td>

            <td class="center">
                {{ $comment['parent_id'] ?? '—' }}
            </td>
        </tr>
    @endforeach
    </tbody>
</table>

</body>
</html>
