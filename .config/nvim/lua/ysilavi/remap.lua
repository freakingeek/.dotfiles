vim.g.mapleader = " "

vim.keymap.set("n", "<C-b>", vim.cmd.Ex)
vim.keymap.set('i', '<C-z>', vim.cmd.undo)
vim.keymap.set("i", "<C-y>", vim.cmd.redo)

vim.keymap.set('i', '<C-s>', vim.cmd.w)

vim.keymap.set("n", "<C-a>", "ggVG")
vim.keymap.set('i', '<C-a>', '<Esc>ggVG')

-- Plugins
vim.keymap.set('i', '<S-Tab>', '<Plug>(emmet-expand-abbr)')
