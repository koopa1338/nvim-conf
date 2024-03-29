# Neovim Config

This repo contains my neovim config used as a submodule in my dotfiles.

![start](./assets/nvim_start.png)
![file finder](./assets/nvim_telescope.png)
![auto completion](./assets/nvim_cmp.png)

## Setup

### Prerequsites

For this config to work you need at least neovim 0.8 release
installed, for full features use the current stable version. The easiest way if
you already have installed the rust toolchain is to install a neovim version
manager called [bob](https://github.com/MordechaiHadad/bob) otherwise download
a release from the repo or install it through your package manager.

the wilder plugin is using python and requires the neovim packages installed
with pip to work. _NOTE_ Install these before you startup neovim for the first
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
`user_settings.lua` (see [Custom Settings](#custom-settings))

### Custom settings

For custom settings see `plugin/user_settings.lua.example`.
Color settings can be done via `lua/colors.lua`,
if not present colors fallback to a default theme

### Snippets

To add your own snippets add a lua file named after the filetype in `luasnippts/`.
For example a simple rust snippet would go into `luasnippets/rust.lua`:

```lua
return {
  s({
    trig = "tmod",
    namr = "test mod",
    dscr = "create mod for tests",
  }, {
    t "#[cfg(test)]",
    t { "", "mod test {" },
    t { "", "\tuse super::*;" },
    t { "", "" },
    t { "", "\t" },
    i(0),
    t { "", "}" },
  }),
}
```
