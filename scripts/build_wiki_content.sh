#!/bin/bash
# Wiki 用コンテンツを starlight/src/content/docs に生成する。
# docs/ 配下はそのままコピーし、ルートの CLAUDE.md / plan.md / brand.md は
# Starlight 用の frontmatter を付けて取り込む（元ファイルは変更しない）。
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/starlight/src/content/docs"

rm -rf "$DEST"
mkdir -p "$DEST"
cp -r "$ROOT"/docs/* "$DEST"/ 2>/dev/null || true

# 引数: 元ファイル / 出力名 / タイトル / 説明
import_md() {
  local src="$1" out="$2" title="$3" desc="$4"
  {
    printf -- '---\ntitle: "%s"\ndescription: "%s"\n---\n\n' "$title" "$desc"
    sed '1{/^# /d}' "$ROOT/$src"
  } > "$DEST/$out"
}

import_md CLAUDE.md rules.md "運用ルール（CLAUDE.md）" "Claude Code への指示・制作の原則・禁止事項"
import_md plan.md plan.md "計画（plan.md）" "目的・フェーズ・記事制作フロー"
import_md brand.md brand.md "ブランドガイド（brand.md）" "ミッション・読者像・トーン・文体ルール"
echo "generated: $DEST"
