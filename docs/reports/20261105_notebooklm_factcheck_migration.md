---
title: NotebookLM によるリサーチ・ファクトチェック基盤の移植
date: 2026-11-05
tags: [skill, infra]
---

← [変更ログへ](../../changelog/)

## 背景・動機

信頼できるソースだけを根拠にファクトチェックでき、参考にした情報の一覧が自動的に得られる、xClaude の NotebookLM 方式を踏襲するため。

## 実施内容

- xClaude から移植：`scripts/notebooklm_browser_bridge.py`、`vendor/notebooklm/`、スキル `research_setup-sources`・`check-fact-lim`
- 移植時の調整：
  - `git rev-parse --show-toplevel` を固定パスに置換
  - 認証確認を Windows 側 Chrome のログイン状態に変更
  - Drive 連携モードは未移植と明記
- 公開リポジトリ化に伴い、SSH 接続先の直書きを除去（環境変数 `NBLM_SSH_HOST` または `.env`。例は `.env.example`）
- 秘密情報の確認：履歴を含めて、トークン・鍵・`.swp` などの混入がないことを検索で確認。`.gitignore` に一時ファイル・`.env` 系を追加
- xClaude 由来でスプレッドシート ID 等を含む `.claude/agents/` と `reporter-*` スキルは、追跡対象外にした
- `CLAUDE.md` に運用方針を記載：記事ごとに 1 ノートブック、ソース限定の照合、生成報告書の混入確認、並行実行禁止

## 変更ファイル

| ファイル | 変更内容 |
|---|---|
| `scripts/notebooklm_browser_bridge.py` | 接続先を `.env` / 環境変数から読むよう変更 |
| `vendor/notebooklm/` | xClaude からコピー |
| `.claude/skills/research_setup-sources/`, `check-fact-lim/` | 移植・パス調整 |
| `.gitignore`, `.env.example` | 除外設定と設定例を追加 |
| `CLAUDE.md`, `plan.md` | リサーチ・ファクトチェック方針を追記 |

## 確認結果

ブリッジの構文チェックと `--help` の動作を確認した。Windows サーバーへの実接続は未確認。

## 設計判断・今後の課題

- 生成報告書がソースに混入すると、AI が AI の出力を検証する循環が起きる（xClaude での事例）。ソース一覧の目視確認を制作フローに含めた
- ブリッジは Windows 常駐 Chrome 1 セッション前提で、xClaude と共有するため並行実行できない
