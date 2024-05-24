-- goals for nvim
--x 1. fuzzy finder
--x 2. command pallet (fzf + fzf-lua) mapped to Shift+P
--x 3. line numbers
--x 4. use mouse
-- 5. color scheme
-- 6. better syntax highliting
-- 7. lsp
-- 8. copilot
-- 9. better indenting
-- 10. git integration(?)
-- 11. debugger
-- 12. folding
-- 13. pair parens, brackets etc
-- 14. code formatter
-- 15. lint on save
require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself
	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",	

}
-- remaps
vim.cmd [[set mouse=a]]

vim.g.mapleader = " "

vim.wo.number = true
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local fzf = require('fzf-lua')
vim.keymap.set('n', '<S-p>', fzf.commands,{})
