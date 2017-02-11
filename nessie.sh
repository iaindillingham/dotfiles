#!/bin/sh

# Preliminaries

PROJECT_HOME='~/Code/nessie'

PROJECT_NAME=`basename ${PROJECT_HOME}`

tmux -2 new-session -s ${PROJECT_NAME} -n editor -d

# Editor

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "vim" C-m

# Git

tmux new-window -t ${PROJECT_NAME} -n git

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "git branch" C-m

tmux split-window -t ${PROJECT_NAME} -h

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

# Shell

tmux new-window -t ${PROJECT_NAME} -n shell

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} python manage.py shell" C-m

# Tox

tmux new-window -t ${PROJECT_NAME} -n tox

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} tox" C-m

# Django

tmux new-window -t ${PROJECT_NAME} -n django

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "export PYTHONPATH=`pwd`" C-m

tmux send-keys -t ${PROJECT_NAME} "export DJANGO_SETTINGS_MODULE='nessie.settings.dev'" C-m

tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} gunicorn nessie.wsgi:application -w 2 -b 127.0.0.1:8000 -t 600 --reload" C-m

# Let's go!

tmux select-window -t ${PROJECT_NAME}:git

tmux -2 attach-session -t ${PROJECT_NAME}
