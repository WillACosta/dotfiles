#!/bin/sh

SESSION="dev_ss"
WORKDIR="$HOME/workspace/projects"

if ! tmux has-session -t "$SESSION" 2>/dev/null; then
	tmux new-session -d -s "$SESSION" -n "wrksp"
	tmux split-window -h -p 40 -t "$SESSION:wrksp"
	tmux send-keys -t "$SESSION:wrksp.1" "cd $WORKDIR && clear" C-m
	tmux send-keys -t "$SESSION:wrksp.2" "cd $WORKDIR && clear" C-m

	tmux new-window -t "$SESSION" -n "llm"
	tmux split-window -h -p 33 -t "$SESSION:llm"
	tmux send-keys -t "$SESSION:llm.1" "cd $WORKDIR && clear" C-m
	tmux send-keys -t "$SESSION:llm.2" "cd $WORKDIR && clear" C-m

	tmux new-window -t "$SESSION" -n "vim"
	tmux send-keys -t "$SESSION:vim.1" "cd $WORKDIR && clear" C-m

	tmux select-window -t "$SESSION:wrksp.1"
fi

tmux attach -t "$SESSION"
