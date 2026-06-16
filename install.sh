#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR"

# CLAUDE.md
ln -sf "$DOTFILES/claude/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "✓ CLAUDE.md"

# settings.json — merge if exists, replace if not
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  echo "⚠ settings.json already exists — skipping (edit manually or delete to replace)"
else
  ln -sf "$DOTFILES/claude/settings.json" "$CLAUDE_DIR/settings.json"
  echo "✓ settings.json"
fi

# Install ponytail plugin if claude CLI is available
if command -v claude &>/dev/null; then
  claude plugin marketplace add https://github.com/DietrichGebert/ponytail 2>/dev/null || true
  claude plugin install ponytail@ponytail 2>/dev/null || true
  echo "✓ ponytail plugin"
fi

echo ""
echo "Done. Run /reload-plugins in Claude Code to apply."
echo ""
echo "For web/mobile sessions: copy claude/project-CLAUDE.md into your project as CLAUDE.md"
