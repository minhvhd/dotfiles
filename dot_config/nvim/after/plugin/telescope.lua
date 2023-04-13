local status, telescope = pcall(require, 'telescope')
if (not status) then return end

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input('Grep > ') })
end)
vim.keymap.set('n', ';;', builtin.resume, {})
