return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",                      -- Belirli versiyona kilitle (HEAD'de breaking change olabilir)

    -- BAĞIMLILIKLAR: Bu pluginler önce yüklenir
    dependencies = {
        "nvim-lua/plenary.nvim",        -- async/utility lib (telescope'un beyni)

        -- C ile yazılmış native fzf sorter — Lua'dan 10-50x hızlı.
        -- build = "make" → klonlandıktan sonra C kodunu derle.
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- ESC ile insert mode'dan çıkmadan önce telescope kapansın
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
                file_ignore_patterns = { "node_modules", ".git/", "dist/", ".next/" },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- fzf-native extension'ını yükle
        telescope.load_extension("fzf")

        -- ============================================================
        -- KEYMAPS — <leader>f* namespace ([F]ind)
        -- ============================================================

        -- Dosya bul (Ctrl-p VS Code'dan tanıyorsundur)
        vim.keymap.set("n", "<leader>ff", builtin.find_files,
            { desc = "[F]ind [F]iles" })

        -- Sadece git'le track edilen dosyalar (node_modules vs hariç)
        vim.keymap.set("n", "<C-p>", builtin.git_files,
            { desc = "Git tracked files" })

        -- Live grep (yazarken anlık eşleşme — en güçlü arama)
        vim.keymap.set("n", "<leader>fg", builtin.live_grep,
            { desc = "[F]ind by [G]rep" })

        -- Grep — kelimeyi sor, projede ara
        vim.keymap.set("n", "<leader>fs", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "[F]ind by [S]earch (kelime sor)" })

        -- Cursor altındaki kelimeyi proje içinde ara
        vim.keymap.set("n", "<leader>fw", builtin.grep_string,
            { desc = "[F]ind current [W]ord" })

        -- Açık buffer'lar arasında geç
        vim.keymap.set("n", "<leader>fb", builtin.buffers,
            { desc = "[F]ind [B]uffers" })

        -- Vim help dökümanı ara
        vim.keymap.set("n", "<leader>fh", builtin.help_tags,
            { desc = "[F]ind [H]elp" })

        -- Recent files (geçmişte açtıkların)
        vim.keymap.set("n", "<leader>fr", builtin.oldfiles,
            { desc = "[F]ind [R]ecent files" })
    end,
}
