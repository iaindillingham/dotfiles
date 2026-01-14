# shellcheck shell=bash

# .bash_aliases
# =============
#
# shfmt --write --language-dialect bash --indent 4 .bash_aliases
#
alias ll='ls -lh'

alias devtools='python -m pip install ipython pdbpp'

alias scratch='tmux new-session -s scratch'

alias jobserverdump='scp dokku4:/var/lib/dokku/data/storage/job-server/jobserver.dump jobserver.dump'

alias jobserverrestore='pg_restore --clean --if-exists --no-acl --no-owner -d jobserver jobserver.dump'
