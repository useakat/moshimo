---
title: xClaude 由来の残存物の整理
date: 2026-11-05
tags: [infra, workflow]
---

← [変更ログへ](../../changelog/)

## 背景・動機

moshimo は xClaude の作業ディレクトリを土台に作ったため、X・note 運用向けのエージェント、日報スキル、設定が残っていた。moshimo では使わず、スプレッドシート ID などを含むファイルもあったため、公開リポジトリにする前に整理する必要があった。

## 実施内容

- 削除：`.claude/agents/`、`reporter-{daily,weekly,monthly}` スキル、`save-session` スキル、`metadata.yaml`、`hashTag-note.md`、`settings_example.json`、`DailyCalendar.astro`、`CLAUDE_temp.md`、空の `docs/chat-history/`
- `.claude/settings.json` を、xClaude のパス参照と X 用の MCP 設定をなくした最小の許可設定に変更
- `update-permissions` スキルのパスとコミット手順を moshimo 用に変更
- `CLAUDE.md`・`plan.md` の残存物に関する記述を更新し、フェーズ 0 の該当項目を完了にした
- `.gitignore` から、不要になった xClaude 用の除外設定を削除

## 変更ファイル

| ファイル | 変更内容 |
|---|---|
| `.claude/settings.json` | 最小の許可設定に変更 |
| `.claude/skills/update-permissions/SKILL.md` | パス・コミット手順を moshimo 用に変更 |
| `CLAUDE.md`, `plan.md`, `.gitignore` | 残存物に関する記述・設定を整理 |
| 上記の削除対象 | 削除 |

## 確認結果

Wiki のビルドが成功することを確認した（11 ページ）。

## 設計判断・今後の課題

- `.claude/settings.local.json` に xClaude 由来の許可設定が残っている。編集できない設定のため、利用者が整理する
