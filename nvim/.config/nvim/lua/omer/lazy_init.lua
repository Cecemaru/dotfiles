-- lazy.nvim'in resmi bootstrap'i: yoksa GitHub'dan klonla, sonra path'e ekle.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "lazy.nvim klonlanamadı:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nEnter'a basıp çık.", "" },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Lazy'yi başlat: lua/omer/lazy/ klasöründeki HER .lua dosyasını plugin spec olarak otomatik yükle.
require("lazy").setup({
    spec = { { import = "omer.lazy" } },          -- klasör tarama
    install = { colorscheme = { "catppuccin" } }, -- ilk kurulumda bu temayı dene
    checker = { enabled = true, notify = false }, -- güncelleme kontrolü, ama uyarı atma
    change_detection = { notify = false },        -- config değişince sessizce reload
})
