---
title: Wiki の整備と GitHub Pages での公開
date: 2026-11-05
tags: [wiki, infra]
---

← [変更ログへ](../../changelog/)

## 背景・動機

ドキュメントを手元のブラウザで確認できるようにするため。リポジトリを公開にしたので、GitHub Pages が使える。

## 実施内容

- GitHub に公開リポジトリ `useakat/moshimo` を作成して push
- Starlight を moshimo 用に整備（タイトル、`base: '/moshimo'`、GitHub リンク、サイドバー）
- `scripts/build_wiki_content.sh` を新設：ルートの `CLAUDE.md` / `plan.md` / `brand.md` に frontmatter を付けて Wiki に取り込む（元ファイルは変更しない）
- `.github/workflows/deploy.yml` の対象ブランチを `main` に変更し、Pages を有効化
- サイドバーに変更ログと報告書を追加
- `/record` スキルを moshimo 向けに調整し、セッション履歴の保存（`scripts/save_session_history.py`）を移植

## 変更ファイル

| ファイル | 変更内容 |
|---|---|
| `starlight/astro.config.mjs` | moshimo 用設定、サイドバー |
| `.github/workflows/deploy.yml` | `main` で動作、生成スクリプトを呼ぶ |
| `scripts/build_wiki_content.sh` | 新規 |
| `docs/index.md`, `docs/changelog.md`, `docs/reports/template.md` | 新規 |
| `.claude/skills/record/SKILL.md` | moshimo 向けに調整 |
| `scripts/save_session_history.py` | xClaude から移植 |

## 確認結果

ローカルでビルド成功。GitHub Actions のデプロイ成功後、https://useakat.github.io/moshimo/ が HTTP 200 を返すことを確認した。

## 設計判断・今後の課題

- Wiki はリポジトリと同様に公開される。セッション履歴を載せる場合は、機密情報の確認が必須（`/record` に手順を追加済み）
