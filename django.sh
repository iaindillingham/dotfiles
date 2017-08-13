#!/bin/sh

# Preliminaries

PROJECT_HOME=$1

# If the first argument is either the empty string or not a directory,
# then exit.
if [ ! -n "$1" ] || [ ! -d "$1" ]; then
    echo "$0 PROJECT_HOME"
    exit 1
fi

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

# Tox

tmux new-window -t ${PROJECT_NAME} -n tox

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} tox" C-m

if [ -e "${PROJECT_HOME}/manage.py" ]; then

    # Shell

    tmux new-window -t ${PROJECT_NAME} -n shell

    tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

    tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} python manage.py shell" C-m

    # Django

    tmux new-window -t ${PROJECT_NAME} -n django

    tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

    tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} python manage.py runserver" C-m

fi

# Let's go!

tmux select-window -t ${PROJECT_NAME}:git

tmux -2 attach-session -t ${PROJECT_NAME}
