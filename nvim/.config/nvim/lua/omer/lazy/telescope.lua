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
        -- KEYMAPS — hepsi <leader>p ile başlar (Prime'ın "Project" namespace'i)
        -- ============================================================

        -- En çok kullanacağın: dosya bul (Ctrl-p VS Code'dan tanıyorsundur)
        vim.keymap.set("n", "<leader>pf", builtin.find_files,
            { desc = "[P]roject [F]iles" })

        -- Sadece git'le track edilen dosyalar (node_modules vs hariç)
        vim.keymap.set("n", "<C-p>", builtin.git_files,
            { desc = "Git tracked files" })

        -- LIVE GREP — proje içinde TÜM dosyalarda kelime ara (ripgrep ile)
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end, { desc = "[P]roject [S]earch (kelime sor)" })

        -- Cursor altındaki kelimeyi proje içinde ara
        vim.keymap.set("n", "<leader>pw", builtin.grep_string,
            { desc = "[P]roject grep [W]ord" })

        -- Live grep (yazarken anlık eşleşme)
        vim.keymap.set("n", "<leader>pg", builtin.live_grep,
            { desc = "[P]roject live [G]rep" })

        -- Açık buffer'lar arasında geç
        vim.keymap.set("n", "<leader>pb", builtin.buffers,
            { desc = "[P]roject [B]uffers" })

        -- Vim help dökümanı ara
        vim.keymap.set("n", "<leader>vh", builtin.help_tags,
            { desc = "[V]im [H]elp" })

        -- Recent files (geçmişte açtıkların)
        vim.keymap.set("n", "<leader>?", builtin.oldfiles,
            { desc = "Geçmiş dosyalar" })
    end,
}
