# .bashrc
# =======
# Personal initialization file, run by interactive shells (non-login). You can set and
# export environment variables, and define aliases, here.
#
# https://www.gnu.org/software/bash/manual/html_node/
#
# shfmt --write --language-dialect bash --indent 4 .bashrc
#
# Initialise tools
# ----------------
eval "$(brew shellenv)"
eval "$(fnm env --use-on-cd)"
eval "$(pyenv init -)"
eval "$(starship init bash)"
eval "$(direnv hook bash)" # must come after other tools that manipulate the prompt

# source "${HOMEBREW_PREFIX}/opt/chruby/share/chruby/chruby.sh"
# source "${HOMEBREW_PREFIX}/opt/chruby/share/chruby/auto.sh"

# Environment variables and aliases
# ---------------------------------
export BASH_SILENCE_DEPRECATION_WARNING=1 # https://support.apple.com/en-gb/HT208050
export DIRENV_LOG_FORMAT=
export EDITOR=nvim
export HOMEBREW_BUNDLE_NO_LOCK=1
export PAGER=most
export PIPX_DEFAULT_PYTHON="${HOME}/.pyenv/versions/3.11.2/bin/python"
export PIP_REQUIRE_VIRTUALENV=1
export PYENV_ROOT="${HOME}/.pyenv"
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
export PATH="${HOME}/.local/bin:${PATH}" # pipx

# Bash completions
# ----------------
source "${HOME}/.config/fzf/fzf.bash"
source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
    [[ -r ${COMPLETION} ]] && source "${COMPLETION}"
done
