-- Sıralama önemli:
-- 1. set.lua    → vim ayarları (numbers, tabs vs) önce yüklensin ki pluginler bunu görsün
-- 2. remap.lua  → temel keymapler (leader bile burada set edilir, lazy'den ÖNCE)
-- 3. lazy_init  → en son: lazy.nvim plugin manager başlat
require("omer.set")
require("omer.remap")
require("omer.lazy_init")
