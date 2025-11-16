#!/bin/sh

SESSION="dev_ss"
WORKDIR="$HOME/workspace/projects"

# Check if session exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
	# Create detached session with the first window
	tmux new-session -d -s "$SESSION" -n "workspace"

	# Runs every new panel is created
	set-hook -g after-split-window 'run-shell "tmux send-keys -t #{pane_id} \"source ~/.zshrc && cd ~/workspace\" Enter"'

	# Split the first window vertically (pane 1)
	tmux split-window -v -t "$SESSION:workspace"

	# Send commands to pane 1
	tmux send-keys -t "$SESSION:workspace.1" "cd $WORKDIR" C-m
	tmux send-keys -t "$SESSION:workspace.1" "cd free_my_mind/fmm" C-m
	# tmux send-keys -t "$SESSION:workspace.1" "conda deactivate" C-m
	tmux send-keys -t "$SESSION:workspace.1" "clear" C-m

	# Send commands to pane 2
	tmux send-keys -t "$SESSION:workspace.2" "cd $WORKDIR" C-m
	#  tmux send-keys -t "$SESSION:workspace.2" "conda deactivate" C-m
	tmux send-keys -t "$SESSION:workspace.2" "clear" C-m

	# Create second window for llm
	tmux new-window -t "$SESSION" -n "llm"
	tmux send-keys -t "$SESSION:llm.1" "cd $WORKDIR/free_my_mind/fmm" C-m
    tmux send-keys -t "$SESSION:llm.1" "gemini" C-m

	# Create third window for nvim
	tmux new-window -t "$SESSION" -n "nvim"
	tmux send-keys -t "$SESSION:nvim.1" "cd $WORKDIR" C-m
	tmux send-keys -t "$SESSION:nvim.1" "clear" C-m

	# Focus the first window pane 1
	tmux select-window -t "$SESSION:workspace.1"
fi

# Attach to the session
tmux attach -t "$SESSION"
