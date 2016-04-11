# runserver window
tmux new-session -s orbis -n runserver -d
tmux send-keys -t orbis:1.1 'workon orbis' C-m
tmux send-keys -t orbis:1.1 'export ORBIS_SETTINGS="settings.py"' C-m
tmux send-keys -t orbis:1.1 'python runserver.py' C-m

# git window
tmux new-window -n git -t orbis
tmux split-window -h -t orbis
tmux send-keys -t orbis:2.1 'cd ~/Code/orbis' C-m
tmux send-keys -t orbis:2.1 'git branch' C-m
tmux send-keys -t orbis:2.2 'cd ~/Code/orbis' C-m
tmux send-keys -t orbis:2.2 'git pull' C-m

tmux attach -t orbis
