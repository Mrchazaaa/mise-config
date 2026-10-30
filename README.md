# Dev environment setup

On Linux or macOS, with `curl` installed, run this one-shot command in a terminal:

```sh
curl -fsSL https://raw.githubusercontent.com/Mrchazaaa/mise-config/main/install.sh | bash
```

The script installs [mise](https://mise.jdx.dev/getting-started.html) if needed, uses mise to install Git, clones this repository to `~/.config/mise-config` (or updates an existing checkout), runs the setup task, and adds mise activation to `~/.bashrc` if it is not already there. Open a new Bash shell or run `source ~/.bashrc` afterward to use mise-managed tools in your current shell. To run the setup task directly from a checkout instead:

```sh
mise run setup
```

This installs Git as a global mise tool and runs the [tmux-config installer](https://github.com/Mrchazaaa/tmux-config), which clones the configuration to `~/.config/tmux/tmux-config` and sets up the tmux config files. Git is available outside this repository once [mise is activated in your shell](https://mise.jdx.dev/getting-started.html#activate-mise). The tmux installer prompts before installing a missing `tmux` package or updating an existing checkout, and backs up any existing config files before replacing them. Run the task again to update the configuration.

The setup task requires `curl`; mise provides Git for the tmux installer.

## Test in Ubuntu

With Docker installed and running, launch a temporary Ubuntu container:

```sh
./eng/test-ubuntu.sh
```

The script mounts this repository at `/workspace`, installs `curl`, then opens a shell without installing mise or Git. Run `./install.sh` there to test the full setup without changing your host's tmux config. Exiting the shell removes the container.
