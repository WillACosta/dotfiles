#!/bin/zsh

echo "This script cleans up common development-related directories."
echo "It will search for 'build', 'node_modules', '.venv', and 'venv' directories."
echo

read "search_path?Enter the directory path to search in (default is ~/workspace/projects): "

if [[ -z "$search_path" ]]; then
  search_path="~/workspace/projects"
fi

# Expand tilde to home directory
search_path=$(eval echo $search_path)

echo
echo "--- Searching for directories to clean in: $search_path ---"
echo

# Use find to locate all target directories
found_dirs=($(find "$search_path" -type d \( -name "build" -o -name "node_modules" -o -name ".venv" -o -name "venv" \) -prune))

if (( ${#found_dirs[@]} == 0 )); then
  echo "No 'build', 'node_modules', '.venv', or 'venv' directories found in '$search_path'."
else
  echo "The following directories will be deleted:"
  for dir in "${found_dirs[@]}"; do
    echo "  $dir"
  done

  echo
  read "confirm?Proceed with deleting these directories? (y/N) "

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo
    for dir in "${found_dirs[@]}"; do
      echo "Deleting: $dir"
      rm -rf "$dir"
    done
    echo
    echo "✅ All selected directories have been deleted."

    # Post-cleanup commands
    local -A post_cleanup_commands
    post_cleanup_commands=(
      "pnpm store prune" "Prune the pnpm store"
    )

    echo
    for cmd in "${(@k)post_cleanup_commands}"; do
      read "run_cmd?Run '${post_cleanup_commands[$cmd]}' ($cmd)? (y/N) "
      if [[ "$run_cmd" =~ ^[Yy]$ ]]; then
        echo "Running '$cmd'..."
        eval "$cmd"
      fi
    done
  else
    echo "❌ Deletion cancelled."
  fi
fi

echo
echo "🎉 Cleanup complete."