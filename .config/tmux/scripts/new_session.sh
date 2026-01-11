#!/bin/bash

# Get session name from argument, default to "session"
session_name="${1:-session}"

# Create new session with the name
session_id=$(tmux new-session -d -P -F '#{session_id}' -s "temp-${session_name}-$$" 2>/dev/null)

if [ -z "$session_id" ]; then
  exit 0
fi

# Rename to just the label, session_manager will add index
tmux rename-session -t "$session_id" "$session_name" 2>/dev/null

# Ensure proper numbering
python3 "$HOME/.config/tmux/scripts/session_manager.py" ensure

tmux switch-client -t "$session_id"
