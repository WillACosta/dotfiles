#!/bin/sh

SESSION="dev_ss"
WORKDIR="$HOME/workspace/projects"

# Check if session exists
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  # Create detached session with the first window
  tmux new-session -d -s "$SESSION" -n "workspace"

  # Split the first window vertically (pane 1)
  tmux split-window -v -t "$SESSION:workspace"

  # Send commands to pane 1
  tmux send-keys -t "$SESSION:workspace.1" "cd $WORKDIR" C-m

  # Send commands to pane 2
  tmux send-keys -t "$SESSION:workspace.2" "cd $WORKDIR" C-m

  # Create second window for llm
  tmux new-window -t "$SESSION" -n "llm"
  tmux send-keys -t "$SESSION:llm.1" "cd $WORKDIR" C-m
  tmux send-keys -t "$SESSION:llm.1" "gemini" C-m

  # Optional: enable status bar
  tmux set-option -t "$SESSION" status on

  # Focus the first window pane 1
  tmux select-window -t "$SESSION:workspace.1"
fi

# Attach to the session
tmux attach -t "$SESSION"
