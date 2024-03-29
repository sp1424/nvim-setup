function setupTreesitter()
    require'nvim-treesitter.configs'.setup {
    ensure_installed = {"go", "lua"},
		auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = true
        }
    }
end
