#!/bin/sh

# Preliminaries

ANNOTATOR_STORE_HOME='/home/iain/Code/annotator-store'

NESSIE_HOME='/home/iain/Code/nessie'

tmux -2 new-session -s nessie -n annotator -d

# Annotator Store

tmux send-keys -t nessie "cd ${ANNOTATOR_STORE_HOME}" C-m

tmux send-keys -t nessie "vex annotator-store python run.py" C-m

# Django

tmux new-window -t nessie -n django

tmux send-keys -t nessie "cd ${NESSIE_HOME}" C-m

tmux send-keys -t nessie "vex nessie python manage.py runserver 127.0.0.1:8000" C-m

# Tox

tmux new-window -t nessie -n tox

tmux send-keys -t nessie "cd ${NESSIE_HOME}" C-m

tmux send-keys -t nessie "vex nessie tox" C-m

# Editor

tmux new-window -t nessie -n editor

tmux send-keys -t nessie "cd ${NESSIE_HOME}" C-m

tmux send-keys -t nessie "vim" C-m

# Git

tmux new-window -t nessie -n git

tmux send-keys -t nessie "cd ${NESSIE_HOME}" C-m

tmux send-keys -t nessie "git branch" C-m

tmux split-window -t nessie -h

tmux send-keys -t nessie "cd ${NESSIE_HOME}" C-m

# Shell

tmux new-window -t nessie -n shell

tmux send-keys -t nessie "cd ${NESSIE_HOME}" C-m

tmux send-keys -t nessie "vex nessie python manage.py shell" C-m

# Let's go!

tmux select-window -t nessie:git

tmux -2 attach-session -t nessie
