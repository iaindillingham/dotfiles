# shellcheck shell=bash

# .bash_profile
# =============
# Personal start-up file, run by login shells. You can set and export environment
# variables here. However, you shouldn't define aliases, because aliases are not copied
# from parent to child.
#
# https://www.gnu.org/software/bash/manual/html_node/
#
# shfmt --write --language-dialect bash --indent 4 .bash_profile

if [[ -f "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi
