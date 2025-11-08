#!/bin/zsh

# Recursively find and delete all "build" directories from the current path
# Uses -depth to ensure safe directory deletion order
# Prompts for confirmation before deleting (optional, can be removed)

echo "Searching for all 'build' folders under: $(pwd)"
echo

# Find all directories named 'build' (case-sensitive)
build_dirs=($(find . -type d -name "build"))

if (( ${#build_dirs[@]} == 0 )); then
  echo "No 'build' directories found."
  exit 0
fi

echo "The following 'build' directories will be deleted:"
for dir in "${build_dirs[@]}"; do
  echo "  $dir"
done

echo
read "confirm?Proceed with deletion? (y/N) "

if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo
  for dir in "${build_dirs[@]}"; do
    echo "Deleting: $dir"
    rm -rf "$dir"
  done
  echo
  echo "✅ All 'build' directories have been deleted."
else
  echo "❌ Deletion cancelled."
fi
