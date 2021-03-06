# https://support.apple.com/en-gb/HT208050
export BASH_SILENCE_DEPRECATION_WARNING=1

# https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'

# https://formulae.brew.sh/formula/bash-completion@2
# https://docs.brew.sh/Shell-Completion
if type brew &>/dev/null; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
        [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
fi

# https://packaging.python.org/guides/installing-stand-alone-command-line-tools/
export PATH="$PATH:/Users/iaindillingham/.local/bin"
export PATH="$PATH:/Users/iaindillingham/Library/Python/3.8/bin"
eval "$(register-python-argcomplete pipx)"

# Put Homebrew curl before macOS curl in my PATH
export PATH="/usr/local/opt/curl/bin:$PATH"

# Put Poetry in my path
# https://python-poetry.org/docs/#installation
export PATH="$HOME/.poetry/bin:$PATH"

# https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
