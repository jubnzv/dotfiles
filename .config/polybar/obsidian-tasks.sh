#!/usr/bin/env bash
# Polybar module: count Obsidian tasks scheduled/due today (or overdue)

VAULT="$HOME/Org/Notes"
TODAY=$(date +%Y-%m-%d)

# Read colors from active theme
green=$(grep '^aqua1' ~/.config/polybar/colors.ini 2>/dev/null | cut -d= -f2 | tr -d ' ')
purple=$(grep '^purple2' ~/.config/polybar/colors.ini 2>/dev/null | cut -d= -f2 | tr -d ' ')
: "${green:=#689d6a}"
: "${purple:=#d3869b}"

# Categorize dated tasks
eval "$(rg -P '[\-\*] \[.\].*[📅⏳✅].*\d{4}-\d{2}-\d{2}' "$VAULT" --glob '*.md' --no-filename 2>/dev/null | \
  awk -v today="$TODAY" '
  {
    d = ($0 ~ /\[[x\-]\]/) ? 1 : 0
    scheduled = ""; due = ""; done_date = ""
    if (match($0, /⏳ ([0-9]{4}-[0-9]{2}-[0-9]{2})/, m)) scheduled = m[1]
    if (match($0, /📅 ([0-9]{4}-[0-9]{2}-[0-9]{2})/, m)) due = m[1]
    if (match($0, /✅ ([0-9]{4}-[0-9]{2}-[0-9]{2})/, m)) done_date = m[1]

    is_today = 0; is_done = 0; is_overdue = 0

    if (done_date == today) is_done = 1

    if (scheduled != "") {
      if (scheduled == today) is_today = 1
      if (scheduled < today && !d) is_overdue = 1
    }
    if (due != "") {
      if (due == today) is_today = 1
      if (due < today && !d) is_overdue = 1
    }

    if (is_done) n_done++
    else if (is_today) n_today++
    else if (is_overdue) n_overdue++
  }
  END {
    printf "n_today=%d n_done=%d n_overdue=%d\n", n_today+0, n_done+0, n_overdue+0
  }
')"

# Count undated incomplete tasks from today's daily note
daily=0
if [[ -f "$VAULT/daily/$TODAY.md" ]]; then
  daily=$(rg -cP '^\s*[\-\*]\s\[ \]' "$VAULT/daily/$TODAY.md" 2>/dev/null || echo 0)
  dated_in_daily=$(rg -cP '^\s*[\-\*]\s\[ \].*[📅⏳]' "$VAULT/daily/$TODAY.md" 2>/dev/null || echo 0)
  daily=$((daily - dated_in_daily))
fi
n_today=$((n_today + daily))

total=$((n_today + n_done + n_overdue))
[[ "$total" -eq 0 ]] && { echo "0"; exit 0; }

out=""
[[ "$n_today" -gt 0 ]] && out+="${n_today}"
[[ "$n_done" -gt 0 ]] && out+="%{F${green}}+${n_done}%{F-}"
[[ "$n_overdue" -gt 0 ]] && out+="%{F${purple}}!${n_overdue}%{F-}"
echo "$out"
