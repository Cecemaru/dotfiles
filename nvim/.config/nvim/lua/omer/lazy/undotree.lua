-- Undotree — Vim'in tree-tabanlı undo geçmişini görselleştirir.
-- Saatler önceki branch'a bile dönebilirsin.
return {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow" },     -- sadece komut çağrılınca yükle (lazy)
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "[U]ndotree toggle" },
    },
}
