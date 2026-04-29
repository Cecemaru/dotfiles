return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",                      -- v1.0 (main) breaking — klasik API için master kalır
        build = ":TSUpdate",                    -- install/update sonrası parser'ları derle
        event = { "BufReadPre", "BufNewFile" }, -- dosya açılırken yükle (hızlı startup)

        dependencies = {
            -- Smart text objects: "af" = around function, "if" = inside function vs.
            -- Aynı master/main geçiş sorunu — biz klasik API kullanıyoruz.
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
        },

        config = function()
            require("nvim-treesitter.configs").setup({

                -- Otomatik kurulacak parser'lar (her dilin AST'ini bilen modül)
                -- Yeni bir dilde kod yazarsan :TSInstall <dil> ile elle de ekleyebilirsin
                ensure_installed = {
                    "lua",          "vim",       "vimdoc",     "query",   -- nvim ekosistemi
                    "javascript",   "typescript","tsx",        "html",    "css",   "json",   -- web
                    "python",       "go",        "rust",                              -- backend
                    "bash",         "yaml",      "toml",       "markdown", "markdown_inline",
                    "gitcommit",    "gitignore", "diff",                              -- git
                    "sql",
                },

                auto_install = true,             -- listede olmayan dil dosyası açarsan otomatik kursun
                sync_install = false,            -- async install (donmasın)

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,  -- sadece treesitter, hem-hem değil
                },

                indent = { enable = true },     -- akıllı auto-indent

                -- Smart text objects (textobjects plugin'i bunu açıyor)
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,                       -- imleç function üzerinde değilse, sonrakini bul
                        keymaps = {
                            ["af"] = "@function.outer",         -- vaf = visual all function
                            ["if"] = "@function.inner",         -- vif = visual inner function (gövde)
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["aa"] = "@parameter.outer",        -- vaa = parametreyi seç (virgül dahil)
                            ["ia"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",         -- bir sonraki function'a zıpla
                            ["]c"] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                        },
                    },
                },
            })
        end,
    },

}
