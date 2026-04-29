-- Blink.cmp = modern, Rust-powered autocompletion. nvim-cmp'den 2-3x hızlı.
-- Built-in snippet engine, LSP/buffer/path tamamlama, fuzzy matcher hepsi içinde.
return {
    "saghen/blink.cmp",

    -- Pre-built binary indir (Rust kodunu makinede compile etmek istemiyorsan)
    -- Belirli bir sürüm pin'le ki API kırılırsa anlamlı şekilde patlasın
    version = "1.*",

    event = "InsertEnter",                  -- sadece insert mode'a girince yükle (lazy)

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- ============================================================
        -- KEYMAP PRESET — varsayılan keymap setleri
        --   "default"  → Tab tamamlama, Ctrl-y kabul (vim klasik)
        --   "super-tab"→ Tab her şey için (snippet jump dahil)
        --   "enter"    → Enter ile kabul
        -- ============================================================
        keymap = { preset = "default" },

        appearance = {
            nerd_font_variant = "mono",     -- icon font (Hack Nerd Font kullanıyoruz, mono variant)
        },

        -- ============================================================
        -- COMPLETION — popup davranışı
        -- ============================================================
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 200 },
            list = {
                selection = { preselect = false, auto_insert = false },
            },
            menu = {
                draw = {
                    treesitter = { "lsp" },     -- LSP kaynaklarını treesitter ile renklendir
                },
            },
        },

        -- ============================================================
        -- SOURCES — öneriler nerelerden gelsin
        -- ============================================================
        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            -- lsp:     LSP server'dan (ts_ls, lua_ls vs)
            -- path:    "/usr/local/..." gibi dosya yolu autocomplete
            -- snippets:built-in snippet engine
            -- buffer:  açık buffer'lardaki kelimeler
        },

        -- Rust fuzzy matcher (ÇOK hızlı). Pre-built binary kullan, derleme yok.
        fuzzy = { implementation = "prefer_rust_with_warning" },

        signature = { enabled = true },     -- function imza popup'ı
    },

    opts_extend = { "sources.default" },
}
