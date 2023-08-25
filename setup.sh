mkdir -p ~/.config/nvim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln init.lua ~/.config/nvim/init.lua

nvim +"PlugInstall --sync" +qa
