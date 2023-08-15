local g = vim.g
local o = vim.o
local opt = vim.opt

-- Indentations
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.expandtab = true

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Clipboard
opt.clipboard = "unnamedplus"

vim.cmd([[autocmd FileType ruby setlocal indentkeys-=.]])

