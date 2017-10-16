# Quick installation

- Install latest iterm2 [nightly](https://www.iterm2.com/nightly/latest)
- Install neovim HEAD and python client
	- `brew tap neovim/homebrew-neovim && brew install --HEAD neovim && pip3 install --upgrade neovim`
- Symlink .vimrc -> .vim/init.vim: `ln -nfs ~/.vim/init.vim ~/.vimrc`
- Fetch latest plugins: `nvim` and `:PlugInstall`
