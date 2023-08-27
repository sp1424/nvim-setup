function setupTelescope()
	telescope = require('telescope')
	telescope.load_extension("live_grep_args")
	telescope.setup {
		file_ignore_patterns = { 'node_modules', 'vendor' }
	}
end
