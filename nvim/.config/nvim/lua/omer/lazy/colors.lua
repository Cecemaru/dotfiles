-- Plugin spec: lazy.nvim'in beklediği format. return ile bir tablo döndürürüz.
return {
    "catppuccin/nvim",                  -- GitHub repo: github.com/catppuccin/nvim
    name = "catppuccin",                -- Lazy bu isimle tanır (config'de kullanırız)
    priority = 1000,                    -- Tema önce yüklensin (default 50, biz 1000 = ilk)
    config = function()                 -- Plugin yüklenince çalışacak fonksiyon
        require("catppuccin").setup({
            flavour = "mocha",          -- latte / frappe / macchiato / mocha
            transparent_background = false,   -- true yap istersen ghostty opacity görünür
            integrations = {            -- diğer pluginleri otomatik renklendir
                cmp = true,
                gitsigns = false,       -- bu pluginleri kullanmıyoruz, false
                nvimtree = false,
                treesitter = true,
                telescope = { enabled = true },
                harpoon = true,
                fugitive = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "underline" },
                        warnings = { "underline" },
                        hints = { "underline" },
                        information = { "underline" },
                    },
                },
            },
        })
        -- Temayı aktif et
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
