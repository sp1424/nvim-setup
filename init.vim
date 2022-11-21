call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'justinmk/vim-sneak'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
call plug#end()

"custom setup
colorscheme gruvbox
map leader a
nmap a \
set number
set tabstop=4
set shiftwidth=4
nmap z <cmd>noh<CR>
let g:sneak#label = 1
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S

"NERD TREE setup:
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"COC setup
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport') 
"toggle autocomplete
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>" 

lua require('dap-go').setup()

lua <<EOF
--telescope key binds
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

--coc keybind
vim.keymap.set('n', '<leader>d', "<Cmd>call CocAction('jumpDefinition')<CR>", {})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF


