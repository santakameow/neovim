# sakanai neovim config

Requires Neovim 0.12+ (`vim.pack`).

## Layout

- `init.lua`: startup and module loading
- `lua/options.lua`: editor options
- `lua/plugins.lua`: plugin declarations
- `lua/plugin-config.lua`: plugin setup and theme
- `lua/lsp.lua`: language servers, completion capabilities, diagnostics, LSP mappings
- `lua/keymaps.lua`: general mappings

## Language servers

Open `:Mason` to install language servers. For Lua, run
`:MasonInstall lua-language-server`, then restart Neovim. Servers installed
through Mason are added to Neovim's PATH; system-installed servers work too.
Enabling a server in `lua/lsp.lua` does not install its executable.

Use `:checkhealth vim.lsp` to diagnose server startup and `:LspLog` to see errors.
LuaLS uses LuaJIT and Neovim runtime definitions by default, while respecting
`.luarc.json` / `.luarc.jsonc` in other projects.

LSP mappings: `gd` definition, `K` hover, `grr` references, `<leader>rn`
rename, `<leader>ca` code action, `<leader>lf` format, `<leader>ld` line
 diagnostics, and `<leader>ll` diagnostics list. The leader key is Space.

Other enabled servers require their corresponding executables. C# uses
`roslyn.nvim` and requires the Roslyn language server and .NET SDK.
