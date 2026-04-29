-- KRİTİK: Leader tuşunu lazy.nvim'den ÖNCE set et, yoksa pluginlerin <leader>x mappingleri yanlış key'e bağlanır.
vim.g.mapleader = " "          -- SPACE = leader (Prime stili)
vim.g.maplocalleader = " "

-- Netrw (built-in file explorer) — Prime "<leader>pv" der buna
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "[P]roject [V]iew (netrw)" })

-- Visual mode'da satır taşıma (J/K ile yukarı-aşağı)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Seçimi aşağı taşı" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Seçimi yukarı taşı" })

-- Aşağıdaki ikisi PRIME'IN EFSANE TROLE'LERİ:

-- J ile alt satırı birleştir AMA imleç yerinde kalsın (varsayılan davranış imleci kaydırır, sinir bozucu)
vim.keymap.set("n", "J", "mzJ`z", { desc = "Alt satırı birleştir, imleci koru" })

-- Ctrl-d / Ctrl-u (yarım sayfa) — imleç ekran ortasında kalsın (gözünüz takip eder)
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Yarım sayfa aşağı, ortada tut" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Yarım sayfa yukarı, ortada tut" })

-- Aramada n/N (sonraki/önceki match) — imleç ortada
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- "Greatest remap ever" (Prime'ın deyimi):
-- Visual mode'da seçili alana yapıştırınca, üzerine yazılan eski içerik clipboard'a GİTMESİN
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Yapıştır ama clipboard'u yeme" })

-- System clipboard'a yank (sadece <leader>y / <leader>Y ile)
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "[Y]ank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "[Y]ank line to system clipboard" })

-- Delete to void register (clipboard kirletme)
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "[D]elete to void" })

-- Ctrl-c → ESC (insert mode'da Ctrl-c = ESC ama bazı autocmd'leri tetiklemiyor, fix)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Q'yu devre dışı bırak (yanlışlıkla Ex mode'a girmek can sıkıcı)
vim.keymap.set("n", "Q", "<nop>")

-- Tmux ile uyum — projeleri hızlıca tmux'ta açmak için (tmux-sessionizer Prime'ın script'i, opsiyonel)
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Hızlı yazma izni (chmod +x)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Bu dosyayı executable yap" })

-- Quick save
vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "[W]rite (save)" })

-- Quickfix navigation (Prime'ın projects-wide search/replace sevgilisi)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Sonraki quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Önceki quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Kelime altındaki tüm match'leri rename (substitute)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "[S]ubstitute kelime under cursor" })
