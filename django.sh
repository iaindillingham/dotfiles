#!/bin/sh

# Preliminaries

PROJECT_HOME=$1

if [ -ne ${PROJECT_HOME} ]; then
    echo 'django.sh PROJECT_HOME'
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

# Let's go!

tmux select-window -t ${PROJECT_NAME}:git

tmux -2 attach-session -t ${PROJECT_NAME}
