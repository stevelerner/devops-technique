mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git Vundle.vim

cp -rf ./.vimrc ~

echo "# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1
# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color" >> ~/.bash_profile
source ~/.bash_profile

vim +PlugInstall +qall
