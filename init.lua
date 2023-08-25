local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim', {as = 'catpuccin'})

vim.call('plug#end')

vim.cmd [[colorscheme catppuccin]]
