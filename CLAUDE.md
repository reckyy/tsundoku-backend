## Version Control — 必須手順

このプロジェクトは **Jujutsu (jj)** でバージョン管理している。詳細なルールは `.claude/rules/jujutsu-rules.md` を参照。

**コード編集を開始する前に、必ず以下の手順を実行すること:**

1. `jj log --ignore-working-copy -r @` で現在の change を確認する。
2. description が空かつ diff が空（empty）なら → `jj describe -m "<description>"` のように description を設定して作業開始。
3. それ以外（すでに作業中 or 完了済み）→ `jj new -m "<description>"` で新しい change を作成。
4. description は `prefix: 日本語の内容` 形式（例: `feat: フォームバリデーションを追加`）。
5. bookmark 名は `<type>/<kebab-case>` 形式で記述する
6. `type` には `feat` / `fix` / `refactor` / `chore` / `docs` / `test` など Conventional Commits に対応する接頭辞を使う
7. bookmark 名に `codex/`、`claude/` などのツール固有 prefix は付けない

**禁止事項:** `git` コマンドの直接使用（`jj git` サブコマンドおよび `gh` CLI は許可）
