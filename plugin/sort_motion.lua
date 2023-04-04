-- sort-motion.lua - Sort based on linewise motions
-- Maintainer:   Andrew Pilsch <https://andrew.pilsch.com>, based on work by Chris Toomey <http://ctoomey.com/>
-- Version:      0.1
-- Source:       http://github.com/oncomouse/sort-motion.nvim

vim.keymap.set("n", "<Plug>(SortMotion)", "<cmd>set operatorfunc=v:lua.require'sort-motion'.sort_motion<CR>g@")
vim.keymap.set("x", "<Plug>(SortMotionVisual)", "<cmd>lua require('sort-motion').sort_motion(vim.fn.visualmode())<CR>")
vim.keymap.set("n", "<Plug>(SortMotionLines)", "<cmd>lua require('sort-motion').sort_lines()<CR>")

-- vim.keymap.set("n", "<Plug>(SortMotion)", "<cmd>set operatorfunc=sort_motion#sort_motion<CR>g@")
-- vim.keymap.set("x", "<Plug>(SortMotionVisual)", "<cmd>call sort_motion#sort_motion(visualmode())<CR>")
-- vim.keymap.set("n", "<Plug>(SortMotionLines)", "<cmd>call sort_motion#sort_lines()<CR>")

if vim.fn.hasmapto("<Plug>(SortMotion)", "n") == 0 and vim.fn.maparg("gs", "n") == "" then
	vim.keymap.set("n", "gs", "<Plug>(SortMotion)")
end
if vim.fn.hasmapto("<Plug>(SortMotionVisual)", "x") == 0 and vim.fn.maparg("gs", "x") == "" then
	vim.keymap.set("x", "gs", "<Plug>(SortMotionVisual)")
end
if vim.fn.hasmapto("<Plug>(SortMotionLines)", "n") == 0 and vim.fn.maparg("gss", "n") == "" then
	vim.keymap.set("n", "gss", "<Plug>(SortMotionLines)")
end
