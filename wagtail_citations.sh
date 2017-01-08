#!/bin/sh

# Preliminaries

PROJECT_HOME='~/Code/wagtail_citations'

PROJECT_NAME=`basename ${PROJECT_HOME}`

tmux -2 new-session -s ${PROJECT_NAME} -n tox -d

# Tox

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "vex ${PROJECT_NAME} tox" C-m

# Editor

tmux new-window -t ${PROJECT_NAME} -n editor

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "vim" C-m

# Git

tmux new-window -t ${PROJECT_NAME} -n git

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

tmux send-keys -t ${PROJECT_NAME} "git branch" C-m

tmux split-window -t ${PROJECT_NAME} -h

tmux send-keys -t ${PROJECT_NAME} "cd ${PROJECT_HOME}" C-m

# Let's go!

tmux -2 attach-session -t ${PROJECT_NAME}
