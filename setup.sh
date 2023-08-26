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

ln init.lua ~/.config/nvim/init.lua
ln -s plugins ~/.config/nvim/plugins

nvim +"PlugInstall --sync" +qa
nvim +":TSInstall lua" +qa
nvim +":TSInstall go" +qa
