#!/bin/sh

# Preliminaries

# If the first argument is either the empty string or not a directory,
# then exit.
if [ ! -n "$1" ] || [ ! -d "$1" ]; then
    echo "$0 PROJECT_ROOT_DIR"
    exit 1
fi

PROJECT_ROOT_DIR=$1

PROJECT_NAME=`basename ${PROJECT_ROOT_DIR}`

tmux -2 new-session -s ${PROJECT_NAME} -n editor -d

# Editor

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_ROOT_DIR}" C-m

tmux send-keys -t ${PROJECT_NAME} "vim" C-m

# Git and http-server

tmux new-window -t ${PROJECT_NAME} -n git

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_ROOT_DIR}" C-m

tmux send-keys -t ${PROJECT_NAME} "http-server" C-m

tmux split-window -t ${PROJECT_NAME} -v

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_ROOT_DIR}" C-m

tmux split-window -t ${PROJECT_NAME} -h

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_ROOT_DIR}" C-m

# Let's go!

tmux select-window -t ${PROJECT_NAME}:git

tmux -2 attach-session -t ${PROJECT_NAME}
