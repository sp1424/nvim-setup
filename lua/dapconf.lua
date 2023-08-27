function setupDap()
	dap = require('dap')
	dap.adapters.go = {
		type = 'executable',
		command = 'node',
		args = { os.getenv('HOME') .. '/.config/debuggers/vscode-go/dist/debugAdapter.js' }
	}
	dap.configurations.go = {
		{
			type = 'go',
			name = 'Debug',
			request = 'launch',
			showLog = true,
			program = "${file}",
			dlvToolPath = vim.fn.exepath('dlv')
		},
	}
end
