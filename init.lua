vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

require("plugins")
require("plugin-config")
require("lsp")
require("keymaps")

if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h13"
end
