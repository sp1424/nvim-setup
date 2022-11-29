call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'justinmk/vim-sneak'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'akinsho/bufferline.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'princejoogie/dir-telescope.nvim'
Plug 'numToStr/FTerm.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'rcarriga/nvim-dap-ui'
call plug#end()

"custom setup
colorscheme catppuccin
let mapleader = "a"
set number
set tabstop=4
set shiftwidth=4
nmap z <cmd>noh<CR>
let g:sneak#label = 1
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
set termguicolors

"NERD TREE setup:
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * set winfixwidth
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
lua <<EOF
--telescope config
local builtin = require('telescope.builtin')
local telescope = require('telescope')
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
telescope.load_extension("dir")
telescope.setup({
    defaults = {
        file_ignore_patterns = { ".git/*"},
    }
})


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
require("bufferline").setup{}

require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

vim.keymap.set('n', '<leader>tt', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

--dap config
vim.keymap.set('n', '<leader>c', "<CMD>lua require'dap'.continue()<CR>") -- start debug session
vim.keymap.set('n', '<leader>b', "<CMD>lua require'dap'.toggle_breakpoint()<CR>") -- breakpoint 
vim.keymap.set('n', '<leader>o', "<CMD>lua require'dap'.step_over()<CR>") -- step over
vim.keymap.set('n', '<leader>i', "<CMD>lua require'dap'.step_in()<CR>") -- step in
require('dap-go').setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("dapui").setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
    	"scopes" 
	},
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "repl",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})
EOF
" config recommendation to leave at the bottom
set guifont=Anonymous\ Pro\ 12 
