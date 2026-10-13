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
-- The native extension is optional; an unbuilt library must not stop startup.
pcall(require("telescope").load_extension, "fzf")

require("blink.cmp").setup {
    keymap = { preset = "default" },
    fuzzy = { implementation = "prefer_rust" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    completion = { documentation = { auto_show = true } },
}


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

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

require("mini.statusline").setup { use_icons = true }

require("mini.diff").setup()


vim.cmd.colorscheme "rose-pine-moon"
