mkdir -p ~/.config/nvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

if which node > /dev/null
then
    echo "node is installed, skipping..."
else
	curl -sL install-node.vercel.app/lts | bash
fi

if which lua-language-server > /dev/null
then
	echo "lua lsp is installed, skipping..."
else
	brew install lua-language-server
fi

if [ -d ~/.config/debuggers/vscode-go ]; then
    echo "vscode-go debugger already installed, skipping" 
else
	(
		mkdir -p ~/.config/debuggers &&
		cd ~/.config/debuggers &&
		git clone https://github.com/golang/vscode-go &&
		cd vscode-go &&
		npm install &&
		npm run compile &&
		echo "vscode-go installed"
	)
fi

ln init.lua ~/.config/nvim/init.lua

rm -rf ~/.config/nvim/lua
cp -r lua ~/.config/nvim/lua

nvim +"PlugInstall --sync" +qa
nvim +":TSInstall lua" +qa
nvim +":TSInstall go" +qa
nvim +":TSInstall bash" +qa
