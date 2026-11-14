# shellcheck shell=bash

# .bashrc
# =======
# Personal initialization file, run by interactive shells (non-login). You can set and
# export environment variables, and define aliases, here.
#
# https://www.gnu.org/software/bash/manual/html_node/
#
# shfmt --write --language-dialect bash --indent 4 bash/.bashrc
#
# Initialise tools
# ----------------
eval "$(brew shellenv)"
eval "$(fnm env --use-on-cd)"

# Environment variables and aliases
# ---------------------------------
export BASH_SILENCE_DEPRECATION_WARNING=1 # https://support.apple.com/en-gb/HT208050
export BAT_THEME="ansi"
export CLICOLOR=1
export EDITOR=nvim
export GIT_COMPLETION_SHOW_ALL=1
export GIT_COMPLETION_SHOW_ALL_COMMANDS=1
export HOMEBREW_BUNDLE_NO_LOCK=1
export PAGER=most
export PIP_REQUIRE_VIRTUALENV=1
export PYTHONDONTWRITEBYTECODE=1

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='--color=light,bg:-1,bg+:-1,fg:-1,fg+:-1,gutter:-1,hl:-1,hl+:-1,pointer:-1'

export HISTCONTROL=ignorespace:ignoredups:erasedups
export HISTFILESIZE=10000
export HISTSIZE=10000
shopt -s histappend

[[ -f "${HOME}/.bash_aliases" ]] && source "${HOME}/.bash_aliases"

# PATH
# ----
export PATH="${HOME}/bin:${PATH}"

# Bash completions
# ----------------
# shellcheck source=/dev/null
source "${HOME}/.config/fzf/fzf.bash"
# shellcheck source=/dev/null
source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
    # shellcheck source=/dev/null
    [[ -r ${COMPLETION} ]] && source "${COMPLETION}"
done
