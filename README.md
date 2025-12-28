# .files

🪴 My workspace and tools settings

### TL;DR

Install via `CURL` or `WGET`

```shell
curl -fsSL https://raw.githubusercontent.com/WillACosta/dotfiles/main/install.sh | bash
wget -qO- https://raw.githubusercontent.com/WillACosta/dotfiles/main/install.sh | bash
```

![current iterm profile](./assets/images/iterm.png)

## Getting Started

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

4. Just run the `install` script, it will install and create symlinks for all config files.

```shell
./install.sh
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
| `grc/`       | Configuration for [Generic Colouriser](https://github.com/garabik/grc/tree/master)                                  |
| `iterm2/`    | Configuration for [iTerm2](https://iterm2.com/)                                                                     |
| `nvimm/`     | Configuration for [Neovim](https://neovim.io/) — using [LazyVim](https://www.lazyvim.org/)                          |

## CLI Commands

| Command                                                       | Description                                                   | Has Dotfiles? |
| ------------------------------------------------------------- | ------------------------------------------------------------- | ------------- |
| [`bat`](https://github.com/sharkdp/bat)                       | A replacement for `cat` command with syntax highlight support | []            |
| [`gemini`](https://geminicli.com/docs/cli)                    | Coding agent by Google.                                       | [x]           |
| [`zk`](https://zk-org.github.io/zk/tips/getting-started.html) | Note-taking CLI management.                                   | [x]           |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide)             | A `cd` command replacement.                                   | []            |

## Keyboards Profile

| Keyboard  | Layout              | Config                                              |
| --------- | ------------------- | --------------------------------------------------- |
| Sillaka54 | QWERTY - Default    | [Config file](./keyboards/silakka_54.vil)           |
| Sillaka54 | QERTY - Corne (3x5) | [Config file](./keyboards/silakka_corne_layout.vil) |
