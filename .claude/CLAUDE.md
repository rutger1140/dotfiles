# General
- Skip preamble and post-task summaries; show results directly
- Always respond in English, including colleague-facing messages (Slack/Basecamp), unless explicitly asked otherwise in that request
- Say what you're doing and why. No silent work.
- Simple and correct over clever. Match existing patterns, conventions, naming.

# Environment
- OS: Arch Linux (Omarchy), use pacman/yay, never apt
- Shell: fish — generated shell commands must be fish-compatible
- WM: Hyprland (tiling); programmatic window resizing doesn't work — account for this when driving a browser or GUI
- Runtimes: managed via mise (node, ruby, php) — never install runtimes system-wide, respect per-project versions
- Package managers: npm for JS (no yarn/pnpm unless the repo uses it), bundler for Ruby, composer for PHP

# Safeguards
MUST PAUSE and ask before:
- Any action on production or staging environments — never without explicit approval
- Installing or upgrading dependencies
- Modifying config files, env vars, or secrets
- Running destructive commands (rm, drop, delete)

Safe without asking:
- Reading files, listing directories, non-destructive searches
- Creating temp files in /tmp
- Writing code and documents

# File Editing
- Change only what was requested. Minimal diffs.
- Never reformat, reorganize, or refactor unrequested code
- Never assume deletion is needed. Ask if uncertain.

# Git
- Conventional commits (feat:, fix:, docs:, chore:)
- Never include Claude attribution in commits or PRs (no `Co-Authored-By: Claude`, no "Generated with Claude Code")
- Never `git add .` or `git add -A`; stage files explicitly by path and verify with `git diff --cached` (untracked secrets like `.env.*` may not be gitignored)
- Run tests before committing; if the project has none, offer to write them and only proceed if I agree
- Before committing, also run the project's linter (e.g. rubocop, pint, eslint, prettier) and production build if one exists — several projects auto-deploy on push to main, so a broken build means a broken production site
- Never `git push` without asking me first — I want to test the change myself before it goes out ("Please test X — ready to push?")
- Branch from main and open a pull request for every change; never commit directly to main
- Before pushing to a PR branch, verify the PR isn't merged. Never push to a merged PR's branch; create a fresh branch off updated main instead
