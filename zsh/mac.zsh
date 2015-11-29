ZSHRC=$(readlink "$HOME"/.zshrc)
ZSH_DIR=$(dirname "$ZSHRC")

export PATH="$HOME/.venv/bin:$HOME/bin:$HOME/Documents/go-zone/bin:$(brew --prefix go)/libexec/bin:$(brew --prefix gnu-sed)/libexec/gnubin:$(brew --prefix coreutils)/libexec/gnubin:$(brew --prefix findutils)/bin:$(brew --prefix ruby)/bin:/usr/local/share/npm/bin:/usr/local/sbin:/usr/local/bin:${PATH}"
export MANPATH="$(brew --prefix gnu-sed)/libexec/gnuman:$MANPATH"
export GOPATH="$HOME/Documents/go-zone"
export NODE_PATH="/usr/local/lib/node_modules"

# Homebrew cask aliases
alias cask_install="brew cask install --appdir=/Applications"
alias cask_uninstall="brew cask uninstall"
alias cask_search="brew cask search"
alias cask_list="brew cask list"
# Set up haste to use our BriteCore server
alias work_haste='HASTE_SERVER=http://hastebin.britecorepro.com haste'
# Vagrant Aliases
alias vud='cd ~/BC-Up && vagrant up dev'
alias vhd='cd ~/BC-Up && vagrant halt dev'
alias vsd='cd ~/BC-Up && vagrant ssh dev'
alias vpd='cd ~/BC-Up && vagrant provision dev'
alias vagrantrun="ssh -i ~/.vagrant.d/insecure_private_key -c none -YC -p2222 vagrant@localhost"
# Better ls alias for Mac
alias ls='ls -GpFh'

PLUGINS=('vagrant' 'brew')
source "$ZSH_DIR/common.zsh"
