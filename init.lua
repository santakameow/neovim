vim.loader.enable()
-- let sync anything with system clipboard
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

-- tabulations
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.undofile = true

vim.o.number = true
-- vim.opt.relativenumber = true

vim.o.wrap = false

-- useless tbh
vim.o.showtabline = 0


vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.mouse = "a"

vim.o.showmode = false

vim.o.breakindent = true

vim.o.signcolumn = "yes"

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

local map = vim.keymap.set
local unmap = vim.keymap.del

vim.pack.add({
	-- file manager
	"https://github.com/stevearc/oil.nvim",

	"https://github.com/folke/flash.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	-- theme
	"https://github.com/folke/tokyonight.nvim",

	"https://github.com/NeogitOrg/neogit",
	"https://github.com/esmuellert/codediff.nvim",

	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-lua/plenary.nvim",

	"https://github.com/nvim-mini/mini.nvim",
	
	"https://github.com/saghen/blink.lib",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/lewis6991/gitsigns.nvim",

	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/todo-comments.nvim",
})

vim.cmd.colorscheme "tokyonight-night"


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

require("neogit").setup()

require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require("telescope").load_extension("fzf")

local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()

local gitsigns = require("gitsigns")
gitsigns.setup({})

require("which-key").setup({
	delay = 0,
	icons = { mappings = vim.g.have_nerd_font },
	-- Document existing key chains
	spec = {
		{ '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
		{ '<leader>t', group = '[T]oggle' },
		{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
		{ 'gr', group = 'LSP Actions', mode = { 'n' } },
	},
})

require("todo-comments").setup({ signs = false })

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.statusline").setup({ use_icons = true })

map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- exit terminal with easier shortcut
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })

local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.lsp.enable({
	'lua_ls',
	'gopls',
})
