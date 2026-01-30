#!/bin/bash

# Fix existing session names like "1-0", "2-1" to have meaningful names
# This script will rename sessions by removing the internal ID suffix

echo "Current sessions:"
tmux list-sessions -F '#{session_name}'
echo ""

# Get all sessions
sessions=$(tmux list-sessions -F '#{session_id}::#{session_name}' 2>/dev/null)

if [ -z "$sessions" ]; then
  echo "No sessions found"
  exit 0
fi

# Process each session
while IFS= read -r entry; do
  [[ -z "$entry" ]] && continue
  
  session_id="${entry%%::*}"
  name="${entry#*::}"
  
  # Check if name matches pattern "N-M" where both N and M are numbers
  if [[ "$name" =~ ^([0-9]+)-([0-9]+)$ ]]; then
    index="${BASH_REMATCH[1]}"
    old_label="${BASH_REMATCH[2]}"
    
    echo "Session '$name' needs fixing (label is just a number: $old_label)"
    echo "  Renaming to: session"
    
    # Just rename to remove the index part, session_manager will re-add it
    tmux rename-session -t "$session_id" "session" 2>/dev/null
  fi
done <<< "$sessions"

# Reapply numbering
echo ""
echo "Re-applying session numbering..."
python3 "$HOME/.config/tmux/scripts/session_manager.py" ensure

echo ""
echo "Updated sessions:"
tmux list-sessions -F '#{session_name}'
