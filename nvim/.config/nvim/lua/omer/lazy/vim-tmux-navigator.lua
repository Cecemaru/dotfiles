-- Tmux pane'leri ve Neovim split'leri arasında seamless geçiş.
-- Ctrl-h/j/k/l → ikisi arasında hangi yön varsa oraya zıpla.
-- Tmux side'da da aynı plugin yüklü olmalı (zaten var).
return {
    "christoomey/vim-tmux-navigator",
    cmd = {                             -- Sadece bu komutlar çağrılınca yükle (lazy load)
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
        "TmuxNavigatorProcessList",
    },
    keys = {                            -- Bu tuşlardan birine basılınca da yükle
        { "<C-h>", "<cmd>TmuxNavigateLeft<cr>",     desc = "Tmux/vim sol pane" },
        { "<C-j>", "<cmd>TmuxNavigateDown<cr>",     desc = "Tmux/vim alt pane" },
        { "<C-k>", "<cmd>TmuxNavigateUp<cr>",       desc = "Tmux/vim üst pane" },
        { "<C-l>", "<cmd>TmuxNavigateRight<cr>",    desc = "Tmux/vim sağ pane" },
        { "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Tmux/vim önceki pane" },
    },
}
