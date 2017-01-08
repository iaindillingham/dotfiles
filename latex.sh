#!/bin/sh

# Preliminaries

SESSION_NAME='latex'

SESSION_HOME='~/Documents/t_pattern_analysis'

tmux -2 new-session -s ${SESSION_NAME} -n editor -d

# Editor window

tmux send-keys -t ${SESSION_NAME} "cd ${SESSION_HOME}" C-m

tmux send-keys -t ${SESSION_NAME} "vim" C-m

# Compile window

tmux new-window -t ${SESSION_NAME} -n compile

tmux send-keys -t ${SESSION_NAME} "cd ${SESSION_HOME}" C-m

# Git window

tmux new-window -t ${SESSION_NAME} -n git

tmux send-keys -t ${SESSION_NAME} "cd ${SESSION_HOME}" C-m

tmux split-window -t ${SESSION_NAME} -h

tmux send-keys -t ${SESSION_NAME} "cd ${SESSION_HOME}" C-m

# Let's go!

tmux -2 attach-session -t ${SESSION_NAME}
