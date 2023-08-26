require 'plugins.floatterm'
require 'plugins.treesitter'
require 'plugins.nerdtree'
require 'plugins.telescope'

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug('catppuccin/nvim', {
	as = 'catpuccin'
})
Plug('nvim-treesitter/nvim-treesitter', {
	run = ':TSUpdate'
})
Plug('numToStr/FTerm.nvim')
Plug('folke/which-key.nvim')
Plug('neoclide/coc.nvim', {
	branch = 'release'
})
Plug('Rigellute/shades-of-purple.vim')
Plug('preservim/nerdtree')
Plug('ryanoasis/vim-devicons')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-live-grep-args.nvim')

vim.call('plug#end')

vim.cmd [[colorscheme catppuccin]]
vim.cmd [[set number]]

local set = vim.opt
set.tabstop = 4
set.shiftwidth = 4
set.softtabstop = 0
set.encoding = 'UTF-8'

vim.g.mapleader = ' '
vim.api.nvim_command('inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"')
vim.api.nvim_command('inoremap <silent><expr> <ESC> coc#pum#visible() ? coc#pum#cancel() : "\\<ESC>"')
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)')
vim.keymap.set('n', 'gr', '<Plug>(coc-references)')
vim.keymap.set('n', '<leader>ff', "<CMD> lua require('telescope.builtin').find_files() <CR>")
vim.keymap.set('n', '<leader>fg', "<CMD> lua require('telescope').extensions.live_grep_args.live_grep_args() <CR>")
vim.keymap.set('n', '<leader>fb', "<CMD> lua require('telescope.builtin').buffers() <CR>")
vim.keymap.set('n', '<leader>fh', "<CMD> lua require('telescope.builtin').help_tags() <CR>")

vim.cmd [[autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')]]
vim.cmd [[autocmd BufWritePost * :call CocAction('format')]]

setupTerminal()
setupTreesitter()
setupNerdtree()
setupTelescope()
