# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install

# ======================
# Personal Configuration
# ======================

# --------
# ENV PATH
# --------
export PATH="/home/jh/.pixi/bin:$PATH"

# ---------------
# Vi Mode Setup
# ---------------

# 减少 ESC 键的延迟（从默认的 0.4 秒降低到 0.01 秒）
export KEYTIMEOUT=1

# 按键绑定
bindkey '^l' autosuggest-accept  # Ctrl+L 接受建议

# Vi 模式光标形状切换
function zle-keymap-select {
  case ${KEYMAP} in
    vicmd)      echo -ne '\e[1 q' ;;  # Normal 模式: 块状光标
    viins|main) echo -ne '\e[5 q' ;;  # Insert 模式: 竖线光标
  esac
}
zle -N zle-keymap-select

# 初始化时设置为竖线光标
function zle-line-init {
  zle -K viins
  echo -ne '\e[5 q'
}
zle -N zle-line-init

# 每次命令执行后重置为竖线光标
function zle-line-finish {
  echo -ne '\e[5 q'
}
zle -N zle-line-finish

# Wayland 剪贴板集成 (使用 wl-copy 和 wl-paste)
function wayland-clip-wrap-widgets() {
    local copy_or_paste=$1
    shift

    for widget in $@; do
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _wayland-clip-wrapped-$widget() {
                zle .$widget
                echo -n \$CUTBUFFER | wl-copy
            }
            "
        else
            eval "
            function _wayland-clip-wrapped-$widget() {
                CUTBUFFER=\$(wl-paste)
                zle .$widget
            }
            "
        fi

        zle -N $widget _wayland-clip-wrapped-$widget
    done
}

# 要包装的复制和粘贴 widgets
local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-after vi-put-before
)

wayland-clip-wrap-widgets copy $copy_widgets
wayland-clip-wrap-widgets paste $paste_widgets

# -------
# Aliases
# -------

# 系统命令
alias c='clear'
alias ll='ls -la'
alias lh='ls -lh'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'

# Git
alias gs='git status'
alias lg='lazygit'

# 开发工具
alias py='python'
alias px='pixi'
alias nv='nvim'

# Tmux
alias t='tmux'
alias ta='tmux attach'
alias tk='tmux kill-session'
alias tl='tmux list-sessions'

# 其他
alias ff='fastfetch'
export PATH="$HOME/.cargo/bin:$PATH"

# Nixos
alias nixrb='sudo nixos-rebuild boot --flake'
alias nixrs='sudo nixos-rebuild switch --flake'

#niri
alias nirisc='niri msg action load-config-file'
