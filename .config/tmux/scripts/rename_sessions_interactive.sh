#!/bin/bash

# Interactive script to rename sessions with numbered labels (like "1-0", "2-1")
# to have meaningful names

echo "=== Tmux Session Renamer ==="
echo ""
echo "Current sessions:"
tmux list-sessions -F '#{session_name}'
echo ""

# Get all sessions
sessions=$(tmux list-sessions -F '#{session_id}::#{session_name}' 2>/dev/null)

if [ -z "$sessions" ]; then
  echo "No sessions found"
  exit 0
fi

needs_fix=0

# Check if any session needs fixing
while IFS= read -r entry; do
  [[ -z "$entry" ]] && continue
  
  session_id="${entry%%::*}"
  name="${entry#*::}"
  
  # Check if name matches pattern "N-M" where both N and M are numbers
  if [[ "$name" =~ ^([0-9]+)-([0-9]+)$ ]]; then
    needs_fix=1
    break
  fi
done <<< "$sessions"

if [ $needs_fix -eq 0 ]; then
  echo "All sessions already have proper names!"
  exit 0
fi

echo "Found sessions with numeric labels. Let's rename them:"
echo ""

# Process each session
while IFS= read -r entry; do
  [[ -z "$entry" ]] && continue
  
  session_id="${entry%%::*}"
  name="${entry#*::}"
  
  # Check if name matches pattern "N-M" where both N and M are numbers
  if [[ "$name" =~ ^([0-9]+)-([0-9]+)$ ]]; then
    index="${BASH_REMATCH[1]}"
    old_label="${BASH_REMATCH[2]}"
    
    echo "Session: $name"
    read -p "  Enter new name (or press Enter to use 'session'): " new_label
    
    if [ -z "$new_label" ]; then
      new_label="session"
    fi
    
    # Rename (session_manager will re-add the index)
    tmux rename-session -t "$session_id" "$new_label" 2>/dev/null
    echo "  Renamed to: $new_label"
    echo ""
  fi
done <<< "$sessions"

# Reapply numbering
echo "Re-applying session numbering..."
python3 "$HOME/.config/tmux/scripts/session_manager.py" ensure

echo ""
echo "=== Updated sessions ==="
tmux list-sessions -F '#{session_name}'
