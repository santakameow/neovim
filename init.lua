vim.loader.enable()
-- let sync anything with system clipboard
vim.schedule(function() vim.opt.clipboard = "unnamedplus" end)

require("options")


vim.g.mapleader = " "

--
-- plugins
--

vim.pack.add {
    "https://github.com/stevearc/oil.nvim", -- file manager

    "https://github.com/folke/flash.nvim",
    "https://github.com/neovim/nvim-lspconfig", -- good
    "https://github.com/seblyng/roslyn.nvim",

    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" }, -- idk why i need this

    -- theme
    "https://github.com/folke/tokyonight.nvim",
    "https://github.com/ellisonleao/gruvbox.nvim",
    { src = "https://github.com/rose-pine/neovim",                name = "rose-pine", },

    -- git
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/esmuellert/codediff.nvim",

    -- idk why i need this
    "https://github.com/nvim-telescope/telescope.nvim",

    -- needed to build by myself
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    "https://github.com/nvim-lua/plenary.nvim",

    -- good
    "https://github.com/nvim-mini/mini.nvim",

    -- good completition
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",

    -- can help
    "https://github.com/folke/which-key.nvim",
    "https://github.com/folke/todo-comments.nvim",
}

require("oil").setup {
    default_file_explorer = true,
    columns = {
        "permissions",
        "size",
        "mtime",
        "icon",
    },

    lsp_file_methods = {
        enabled = true,
        autosave_changes = true,
        timeout_ms = 1000,
    },
}

-- require("Otree").setup()

require("flash").setup()

require("neogit").setup()

require("telescope").setup {
    extensions = {
        fzf = {
            fuzzy = true,             -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}
require("telescope").load_extension("fzf")

local cmp = require 'blink.cmp'
cmp.build():pwait()
cmp.setup()


require("which-key").setup {
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
        { '<leader>s', group = '[S]earch',    mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk',  mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
        { 'gr',        group = 'LSP Actions', mode = { 'n' } },
    },
}

require("todo-comments").setup {}

-- im not a gay btw but this kinda hot

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.statusline").setup({ use_icons = true })

require("mini.diff").setup()


--
-- keymaps
--

require("keymaps")

vim.lsp.config["lua_ls"] = {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
                globals = {
                    "vim"
                }
            },
        }
    }
}

vim.lsp.enable {
    'lua_ls',
    'gopls',
    'clangd',
    'rust-analyzer',
    'zls',
    'ruff',   -- python lang server
    'taplo',  -- toml lang server
    'nixd',
    'roslyn', -- csharp lang server
}

-- vim.cmd.colorscheme "gruvbox"
vim.cmd.colorscheme "rose-pine-moon"




if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font:h13"
end
