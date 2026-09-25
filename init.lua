vim.pack.add({
	-- file manager
	"https://github.com/stevearc/oil.nvim",
	-- 
	"https://github.com/folke/flash.nvim",
	--
	"https://github.com/neovim/nvim-lspconfig",
	-- 
	"https://github.com/nvim-treesitter/nvim-treesitter",
	-- theme
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/nvim-mini/mini.icons",


	"https://github.com/NeogitOrg/neogit",
	"https://github.com/esmuellert/codediff.nvim",

	"https://github.com/m00qek/baleia.nvim",


})

require("oil").setup({
	default_file_explorer = true,
	columns = {
		-- "permissions",
		"icon",
	},

	lsp_file_methods = {
		enabled = true,
		autosave_changes = true,
		timeout_ms = 1000,
	},
})

require("flash").setup()

require("neogit").setup({
	kind = "replace",
})

-- let sync anything with system clipboard
vim.opt.clipboard = "unnamedplus"

-- tabulations
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.ignorecase = true
vim.o.smartcase = true

vim.opt.undofile = true

vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.wrap = false

-- useless tbh
vim.opt.showtabline = 0

vim.lsp.enable({
	'lua_ls',
	'gopls',
})

vim.cmd [[colorscheme tokyonight]]

vim.g.mapleader = " "

local map = vim.keymap.set
local unmap = vim.keymap.del

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })


