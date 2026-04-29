-- LSP — modern nvim 0.11+ API ile (vim.lsp.config)
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        "saghen/blink.cmp",                         -- capabilities için
        -- lazydev: lua_ls'e "bu nvim config" der, vim global ve nvim API'si tanınsın
        { "folke/lazydev.nvim", ft = "lua",
          opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },
    },

    config = function()
        -- ============================================================
        -- 1. ÖNCE config'leri ayarla (mason-lspconfig enable etmeden!)
        -- ============================================================

        -- GLOBAL capabilities (blink.cmp tüm LSP'lere bağlansın)
        vim.lsp.config("*", {
            capabilities = require("blink.cmp").get_lsp_capabilities(),
        })

        -- Lua_ls — lazydev.nvim zaten library'i hallediyor, biz minimum tutuyoruz
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    completion = { callSnippet = "Replace" },
                },
            },
        })

        -- ============================================================
        -- 2. SONRA mason-lspconfig'e söyle: kur ve enable et
        -- ============================================================
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",       -- Lua (nvim config için)
                "ts_ls",        -- TypeScript / JavaScript
                "html",         -- HTML
                "cssls",        -- CSS
                "jsonls",       -- JSON
                "yamlls",       -- YAML
                "bashls",       -- Bash
                "pyright",      -- Python
                -- "gopls",     -- Go yüklü olduğunda ekle (brew install go)
                -- "rust_analyzer", -- Rust toolchain ile gelen analyzer kullanırsan ayrı kurma
            },
            automatic_enable = true,
        })

        -- ============================================================
        -- 4. KEYMAPS — LSP buffer'a attach olunca aktif olsun
        -- ============================================================
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buf = args.buf
                local opts = function(desc) return { buffer = buf, desc = "LSP: " .. desc } end

                vim.keymap.set("n", "gd", vim.lsp.buf.definition,        opts("[G]oto [D]efinition"))
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration,       opts("[G]oto [D]eclaration"))
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation,    opts("[G]oto [I]mplementation"))
                vim.keymap.set("n", "gr", vim.lsp.buf.references,        opts("[G]oto [R]eferences"))
                vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,   opts("[G]oto [T]ype"))

                vim.keymap.set("n", "K",  vim.lsp.buf.hover,             opts("Hover docs"))
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts("Signature help"))

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,    opts("[R]e[n]ame"))
                vim.keymap.set({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, opts("[C]ode [A]ction"))

                vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end,
                    opts("[F]ormat"))

                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,      opts("Önceki diagnostic"))
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next,      opts("Sonraki diagnostic"))
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts("[V]iew [D]iagnostic"))
                vim.keymap.set("n", "<leader>q",  vim.diagnostic.setloclist,  opts("Diagnostics quickfix"))
            end,
        })

        -- ============================================================
        -- 5. Diagnostic görünüm tercihleri
        -- ============================================================
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })
    end,
}
