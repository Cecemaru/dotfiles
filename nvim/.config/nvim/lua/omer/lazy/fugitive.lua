-- vim-fugitive — Tim Pope'un git wrapper'ı. Nvim içinden tam git deneyimi.
-- :G veya :Git → status buffer; :G blame, :Gdiffsplit (merge conflict için altın)
return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gread", "Gwrite", "Gedit", "Ggrep", "GBrowse" },
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "[G]it [S]tatus" },
    },
}
