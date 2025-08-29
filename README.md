# .files

🪴 My workspace and tools settings

## Getting Started

### TL;DR

Install via `CURL` or `WGET`

```shell
curl -fsSL https://raw.githubusercontent.com/WillACosta/dotfiles/main/install.sh | bash
wget -qO- https://raw.githubusercontent.com/WillACosta/dotfiles/main/install.sh | bash
```

1. Clone this repository

```shell
git clone https://github.com/WillACosta/dotfiles.git
```

2. Give permissions to the scripts.

```shell
chmod +x bootstrap.sh
chmod +x path/to/repo/tmux/start_dev.sh
```

3. Switch for bash if it's activated yet

```shell
bash
```

> Make sure bash version is 4.x+

4. Just runs the `bootstrap` script, it will create the symbolic links for all config files.

```shell
./bootstrap.sh
```

## Current Dotfiles

| Dotfile      | Description                                                                                                         |
| ------------ | ------------------------------------------------------------------------------------------------------------------- |
| `aerospace/` | Configuration for the [Aerospace](https://github.com/nikitabobko/AeroSpace) tiling window manager for macOS.        |
| `borders/`   | Configuration for the [borders](https://github.com/dcosma/borders) utility, often used with tiling window managers. |
| `hyper/`     | Configuration for the [Hyper](https://hyper.is/) terminal.                                                          |
| `tmux/`      | Configuration for the [tmux](https://github.com/tmux/tmux/wiki) terminal multiplexer.                               |
| `vscode/`    | User settings for [Visual Studio Code](https://code.visualstudio.com/).                                             |
| `zsh/`       | Configuration for the [Zsh](https://zsh.org) shell.                                                                 |
