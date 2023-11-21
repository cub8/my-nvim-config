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

-- Autoformat
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

-- I had some issues with Ruby indentations I guess? I don't remember
vim.cmd([[autocmd FileType ruby setlocal indentkeys-=.]])
