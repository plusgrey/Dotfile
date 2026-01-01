#!/usr/bin/env bash
set -euo pipefail

# hide entire right status if terminal width is below threshold
min_width=${TMUX_RIGHT_MIN_WIDTH:-90}
width=$(tmux display-message -p '#{client_width}' 2>/dev/null || true)
if [[ -z "${width:-}" || "$width" == "0" ]]; then
  width=$(tmux display-message -p '#{window_width}' 2>/dev/null || true)
fi
if [[ -z "${width:-}" || "$width" == "0" ]]; then
  width=${COLUMNS:-}
fi
if [[ -n "${width:-}" && "$width" =~ ^[0-9]+$ ]]; then
  if (( width < min_width )); then
    exit 0
  fi
fi

status_bg=$(tmux show -gqv status-bg)
if [[ -z "$status_bg" || "$status_bg" == "default" ]]; then
  status_bg=black
fi

segment_bg="#3b4252"
segment_fg="#eceff4"
# DateTime colors to mirror left active style
datetime_bg="${TMUX_THEME_COLOR:-#FFC0CB}"
datetime_fg="#1d1f21"
separator=""
right_cap="█"

# 获取当前日期和时间
datetime=$(date '+%Y-%m-%d %H:%M')

rainbarf_bg="#2e3440"
rainbarf_segment=""
rainbarf_toggle="${TMUX_RAINBARF:-1}"

case "$rainbarf_toggle" in
  0|false|FALSE|off|OFF|no|NO)
    rainbarf_toggle="0"
    ;;
  *)
    rainbarf_toggle="1"
    ;;
esac

if [[ "$rainbarf_toggle" == "1" ]] && command -v rainbarf >/dev/null 2>&1; then
  rainbarf_output=$(rainbarf --no-battery --no-remaining --no-bolt --tmux --rgb 2>/dev/null || true)
  rainbarf_output=${rainbarf_output//$'\n'/}
  if [[ -n "$rainbarf_output" ]]; then
    rainbarf_segment=$(printf '#[fg=%s,bg=%s]%s#[fg=%s,bg=%s]%s' \
      "$rainbarf_bg" "$status_bg" "$separator" \
      "$segment_fg" "$rainbarf_bg" "$rainbarf_output")
  fi
fi

# Build a connector into the datetime segment using datetime colors
datetime_connector_bg="$status_bg"
if [[ -n "$rainbarf_segment" ]]; then
  datetime_connector_bg="$rainbarf_bg"
fi
datetime_prefix=$(printf '#[fg=%s,bg=%s]%s#[fg=%s,bg=%s] ' \
  "$datetime_bg" "$datetime_connector_bg" "$separator" \
  "$datetime_fg" "$datetime_bg")

printf '%s%s%s #[fg=%s,bg=%s]%s' \
  "$rainbarf_segment" \
  "$datetime_prefix" \
  "$datetime" \
  "$datetime_bg" "$status_bg" "$right_cap"
