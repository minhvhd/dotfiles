-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 50
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "120"

vim.g.mapleader = " "

-- add asterisks in block comments
vim.opt.formatoptions:append { 'r' }

-- highlight yanked text for 250ms
vim.cmd [[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({ higroup="Visual", timeout=250 })
    augroup END
]]
