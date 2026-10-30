#!/usr/bin/env bash
set -euo pipefail

repo_url="https://github.com/Mrchazaaa/mise-config.git"
install_dir="$HOME/.config/mise-config"

command -v curl >/dev/null 2>&1 || { printf 'curl is required.\n' >&2; exit 1; }

if ! command -v mise >/dev/null 2>&1; then
  curl -fsSL https://mise.run | sh
fi
export PATH="$HOME/.local/bin:$PATH"
command -v mise >/dev/null 2>&1 || { printf 'mise installation failed.\n' >&2; exit 1; }

if [[ -d "$install_dir/.git" ]]; then
  mise exec conda:git@latest -- git -C "$install_dir" pull --ff-only
elif [[ -e "$install_dir" ]]; then
  printf '%s exists and is not a Git checkout.\n' "$install_dir" >&2
  exit 1
else
  mkdir -p "$(dirname "$install_dir")"
  mise exec conda:git@latest -- git clone "$repo_url" "$install_dir"
fi

cd "$install_dir"
# A script piped into bash has no terminal on stdin; restore it for installer prompts.
if [[ -t 2 ]]; then
  mise run setup </dev/tty
else
  mise run setup
fi
