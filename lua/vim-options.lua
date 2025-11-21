vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.number = true
-- general mappings
vim.cmd("nnoremap <Leader>h :noh<cr>")
-- python comment block mapping
vim.cmd("vnoremap <silent> # :s/^/#/<cr>:noh<cr>")
vim.cmd("vnoremap <silent> -# :s/^#//<cr>:noh<cr>")

local map = vim.keymap.set

-- map for quick quit, save files using leader key
---- Normal mode
map('n', '<Leader>w', ':write<CR>')
map('n', '<Leader>a', ':wqa<CR>')
map('n', '<Leader>x', ':wq<CR>')

---- Insert mode
map('i', ';w', '<esc>:write<CR>')
map('i', ';x', '<esc>:wq<CR>')

-- use U for redo :))
map('n', 'U', '<C-r>', {})

-- close buffer
map('n', '<Leader>c', ':bd<CR>')
