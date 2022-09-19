# Neovim Config

This repo contains my neovim config used as a submodule in my dotfiles.

## Setup

### Prerequsites

For this config to work you need at least the latest neovim stable release
installed, for full features use the nightly version. The easiest way if you
already have installed the rust toolchain is to install a neovim version
manager called (bob)[https://github.com/MordechaiHadad/bob] otherwise download
a release from the repo or install it through your package manager.

the wilder plugin is using python and requires the neovim packages installed
with pip to work. *NOTE* Install these before you startup neovim for the first
time otherwise the plugin will not pickup these packages and you have to
manually reinstall wilder.

### Installation

To enable this config clone this repository directly to `~/.config/nvim` or
create an symbolic link. On first startup the bootstrap process starts and
installs all plugins. After that restart neovim and you should be good to go.

#### Language servers

To install a Language server use the `:Mason` command for the interface or
install shorthand with `:MasonInstall <language server name>`. If you want
custom options or didn't install the server via mason you have to add it to
`lsp_custom.lua` (see `lsp_custom.lua.example`)

