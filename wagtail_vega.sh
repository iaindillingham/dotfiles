#!/bin/sh

# Preliminaries

PROJECT_HOME='/home/iain/Code/wagtail_vega'

tmux -2 new-session -s wagtail_vega -n tox -d

# Tox

tmux send-keys -t wagtail_vega "cd ${PROJECT_HOME}" C-m

tmux send-keys -t wagtail_vega "vex wagtail_vega tox" C-m

# Editor

tmux new-window -t wagtail_vega -n editor

tmux send-keys -t wagtail_vega "cd ${PROJECT_HOME}" C-m

tmux send-keys -t wagtail_vega "vim" C-m

# Git

tmux new-window -t wagtail_vega -n git

tmux send-keys -t wagtail_vega "cd ${PROJECT_HOME}" C-m

tmux send-keys -t wagtail_vega "git branch" C-m

tmux split-window -t wagtail_vega -h

tmux send-keys -t wagtail_vega "cd ${PROJECT_HOME}" C-m

# Let's go!

tmux attach-session -t wagtail_vega
