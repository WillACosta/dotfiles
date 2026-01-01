#!/bin/zsh

# This script combines three cleaning actions:
# 1. Prunes the pnpm store.
# 2. Deletes all 'build' directories.
# 3. Deletes all 'node_modules' directories.

# --- pnpm store pruning ---
echo "--- Step 1: Pruning pnpm store ---"
pnpm store prune
echo "✅ pnpm store pruned."
echo

# --- 'build' directory deletion ---
echo "--- Step 2: Searching for 'build' directories ---"
echo "Searching for all 'build' folders under: $(pwd)"
echo

build_dirs=($(find . -type d -name "build"))

if (( ${#build_dirs[@]} == 0 )); then
  echo "No 'build' directories found."
else
  echo "The following 'build' directories will be deleted:"
  for dir in "${build_dirs[@]}"; do
    echo "  $dir"
  done

  echo
  read "confirm?Proceed with deleting 'build' directories? (y/N) "

  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo
    for dir in "${build_dirs[@]}"; do
      echo "Deleting: $dir"
      rm -rf "$dir"
    done
    echo
    echo "✅ All 'build' directories have been deleted."
  else
    echo "❌ Deletion of 'build' directories cancelled."
  fi
fi
echo

# --- 'node_modules' directory deletion ---
echo "--- Step 3: Searching for 'node_modules' directories ---"
setopt localoptions nullglob

typeset -a dirs_to_visit
typeset -a found
dirs_to_visit=(.)

for (( i = 1; i <= ${#dirs_to_visit}; i++ )); do
  current=${dirs_to_visit[i]}
  for child in "$current"/*(/N); do
    if [[ ${child:t} == "node_modules" ]]; then
      found+=("$child")
    else
      dirs_to_visit+=("$child")
    fi
  done
done

if (( ${#found} == 0 )); then
  echo "No 'node_modules' directories found under: $(pwd)"
else
  echo "Found ${#found} 'node_modules' directories:"
  for d in "${found[@]}"; do
    echo "  $d"
  done

  echo
  read "reply?Delete all listed 'node_modules' directories? (y/N) "
  if [[ ! $reply =~ ^[Yy]$ ]]; then
    echo "❌ Deletion of 'node_modules' directories cancelled."
  else
    echo
    for d in "${found[@]}"; do
      echo "Deleting: $d"
      rm -rf -- "$d"
    done
    echo
    echo "✅ Done. Deleted ${#found} 'node_modules' directories."
  fi
fi

echo
echo "🎉 All cleaning operations complete."
