-- Harpoon v2 — Prime'ın efsane file-bookmark plugin'i.
-- Dosyaları "harpoon"la, Ctrl-1/2/3/4 ile anlık zıpla. Buffer switching'den 100x hızlı.
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",                    -- v2 zorunlu, v1 deprecated
    dependencies = { "nvim-lua/plenary.nvim" },

    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()                     -- default config

        -- KEYMAPS
        -- <leader>a: mevcut dosyayı harpoon listesine EKLE
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
            { desc = "Harpoon: [A]dd file" })

        -- <C-e>: harpoon UI menüsünü aç (tüm bookmark'ları gör)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: menüyü aç" })

        -- <leader>1/2/3/4 → bookmark'a ANLIK zıpla
        -- (Ctrl-1/2/3/4 terminal protokol sınırı: çoğu terminalde "1" ile aynı keycode)
        vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
        vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
        vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })

        -- Liste içinde önceki/sonraki bookmark
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end,
}
