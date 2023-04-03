-- sort-motion.lua - Sort based on linewise motions
-- Maintainer:   Andrew Pilsch <https://andrew.pilsch.com>, based on work by Chris Toomey <http://ctoomey.com/>
-- Version:      0.1
-- Source:       http://github.com/oncomouse/sort-motion.nvim

vim.keymap.set("n", "<Plug>(SortMotion)", "<cmd>set operatorfunc=v:lua.require'sort-motion'.sort_motion<CR>g@")
vim.keymap.set("x", "<Plug>(SortMotionVisual)", "<cmd>lua require('sort-motion').sort_motion('visual')<CR>")
vim.keymap.set("n", "<Plug>(SortMotionLines)", "<cmd>lua require('sort-motion').sort_lines()<CR>")

vim.keymap.set("n", "gs", "<Plug>(SortMotion)")
vim.keymap.set("x", "gs", "<Plug>(SortMotionVisual)")
vim.keymap.set("n", "gss", "<Plug>(SortMotionLines)")
