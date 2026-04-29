-- Vim'in DAVRANIŞ ayarları. Hiçbir plugin yok, saf vim seçenekleri.

-- Satır numaraları
vim.opt.nu = true                  -- mevcut satır numarası
vim.opt.relativenumber = true      -- diğerleri "buraya kaç satır" göstersin (jjjj demek 4j)

-- Indent / tab davranışı
vim.opt.tabstop = 4                -- bir tab kaç boşluk gösterir
vim.opt.softtabstop = 4            -- backspace kaç boşluk siler
vim.opt.shiftwidth = 4             -- > < ile indent kaç boşluk
vim.opt.expandtab = true           -- tab tuşu boşluk yazsın (gerçek \t değil)
vim.opt.smartindent = true         -- yeni satırda otomatik indent

-- Wrap kapalı (uzun satırlar yana kaydırma yapsın, alt satıra geçmesin)
vim.opt.wrap = false

-- Backup yok, undo dosyası VAR (undotree için kritik)
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true            -- nvim'i kapatıp açsan bile undo geçmişi kalır

-- Arama davranışı
vim.opt.hlsearch = false           -- arama sonra highlight kalmasın (rahatsız edici)
vim.opt.incsearch = true           -- yazarken canlı eşleşme göster
vim.opt.ignorecase = true          -- aramada büyük/küçük yoksay
vim.opt.smartcase = true           -- AMA büyük harf yazarsan case-sensitive olsun

-- Renk
vim.opt.termguicolors = true       -- 24-bit renk (catppuccin için şart)

-- Scrolling
vim.opt.scrolloff = 8              -- imleç ekran kenarına 8 satır kala scroll'lasın
vim.opt.signcolumn = "yes"         -- sol işaret kolonu hep açık (LSP/git ikonları için, layout zıplamasın)

-- Performance
vim.opt.updatetime = 50            -- LSP/CursorHold event'leri daha responsive

-- Görsel
vim.opt.colorcolumn = "100"        -- 100. kolonda dikey çizgi (uzun satır uyarısı)

-- Leader tuşunu burada SET ETMEYELİM — remap.lua'nın ilk satırında set edeceğiz
-- (lazy.nvim leader'ı erken bilmek zorunda)
