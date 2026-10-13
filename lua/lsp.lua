-- Mason puts installed language servers on Neovim's PATH.
-- Install more servers with :Mason (nvim-lspconfig does not install binaries).
require("mason").setup()

vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("lua_ls", {
    on_init = function(client)
        local root = client.root_dir
        -- Respect project-specific Lua settings outside this Neovim config.
        if root and root ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc")) then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
            diagnostics = { globals = { "vim", "MiniIcons" } },
            workspace = {
                checkThirdParty = false,
                -- Loading the entire runtimepath is expensive and indexes unrelated plugins.
                library = { vim.env.VIMRUNTIME },
            },
        })
    end,
    settings = { Lua = { completion = { callSnippet = "Replace" } } },
})

vim.lsp.enable {
    "lua_ls",
    "gopls",
    "clangd",
    "rust_analyzer", -- config name uses an underscore; the executable uses a hyphen
    "zls",
    "ruff",
    "taplo",
    "nixd",
}

-- Roslyn manages its own solution detection and server activation.
require("roslyn").setup()

vim.diagnostic.config {
    severity_sort = true,
    float = { border = "rounded", source = true },
    underline = true,
    signs = true,
    virtual_text = { spacing = 2, source = "if_many" },
    update_in_insert = false,
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
    callback = function(event)
        local function map(key, action, desc)
            vim.keymap.set("n", key, action, { buffer = event.buf, desc = desc })
        end
        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("grr", vim.lsp.buf.references, "LSP references")
        map("gri", vim.lsp.buf.implementation, "LSP implementation")
        map("K", vim.lsp.buf.hover, "LSP hover")
        map("<leader>rn", vim.lsp.buf.rename, "LSP rename")
        map("<leader>ca", vim.lsp.buf.code_action, "LSP code action")
        map("<leader>lf", function() vim.lsp.buf.format { async = true } end, "LSP format")
    end,
})

vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
vim.keymap.set("n", "<leader>ll", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
