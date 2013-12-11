#!/bin/bash

E_ARGUMENT=11 # change later?

linux_check_pkg () {
  if [ -z "$1" ]; then return "$E_ARGUMENT"; fi
  dpkg -s "$1" 2>&1 | grep -q "install ok installed"
}

linux_install_pkg () {
  if [ -z "$1" ]; then return "$E_ARGUMENT"; fi
  if linux_check_pkg "$1"; then
	echo "$1 already installed... skipping"
  else
	sudo apt-get install "$1" -y
  fi
}

linux_setup () {

  # Return unless specific version is supported
  if cat /etc/lsb-release | grep -q -e '10.04' -e '12.04' -e '13.10'; then
    echo "Detected supported Ubuntu..."
  else
	echo "Unsupported Linux; skipping setup"; return
  fi


  echo -e "\nStarting package installation (may require sudo password)"
  linux_install_pkg "ack-grep"
  linux_install_pkg "exuberant-ctags"
  linux_install_pkg "xclip"
  linux_install_pkg "vim-gtk"
  linux_install_pkg "ruby"
  linux_install_pkg "ruby1.9.1-dev"
  linux_install_pkg "ruby1.8-dev"
  echo -e "Package installation complete!\n"

}

osx_check_pkg () {
  if [ -z "$1" ]; then return "$E_ARGUMENT"; fi
  brew list "$1" > /dev/null 2>&1
}

osx_install_pkg () {
  if [ -z "$1" ]; then return "$E_ARGUMENT"; fi
  if osx_check_pkg "$1"; then
	echo "$1 already installed... skipping"
  else
	brew install "$1"
  fi
}

osx_setup () {

  echo "Detected OS X..."
  if command -v brew >/dev/null 2>&1; then
	echo "Homebrew detected... skipping"
  else
	echo "Installing Homebrew..."
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
	echo "Homebrew install complete!"
  fi

  if brew doctor | grep -q "ready to brew"; then
	echo "Homebrew configuration looks good!"
  else
	echo "WARNING!!! Correct any errors/warnings from 'brew doctor'"
  fi

  osx_install_pkg ack
  osx_install_pkg tmux
  osx_install_pkg ctags
  osx_install_pkg xclip
  osx_install_pkg reattach-to-user-namespace

}

setup () {
  echo "Starting $OSTYPE setup..."
  case "$OSTYPE" in
	linux-gnu ) linux_setup  ;;
	darwin*   ) osx_setup    ;;
	cygwin    ) cygwin_setup ;;
  esac
  echo "Setup for $OSTYPE complete!"
}

setup

safe_link () {
  if [ -z "$1" ]; then return "$E_ARGUMENT"; fi
  if [ -z "$2" ]; then target=$1; else target=$2; fi
  # If not a symbolic link or directory, backup first
  if [[ ! -L "$HOME/.$1" && ! -d "$HOME/.$1"  && -e $HOME/.$1 ]]; then
	echo "Making backup of $HOME/.$1 at $HOME/.${1}.dotfile_backup"
	mv "$HOME/.$1" "$HOME/.${1}.dotfile_backup"
  fi
  echo "linking $1 to $target"
  ln -sf "$HOME/dotfiles/$1" "$HOME/.$target"
}

dotfile_links () {
  echo "Linking dotfiles..."
  safe_link "bash_profile"
  safe_link "bashrc"
  safe_link "vimrc"
  safe_link "vimrc.local"
  safe_link "vimrc.bundles"
  safe_link "vimrc.bundles.local"
  safe_link "gvimrc"
  safe_link "dotvim" "vim"
  safe_link "tmux.conf"
  safe_link "ackrc"
  safe_link "gitconfig"
  safe_link "bash/inputrc" "inputrc"
  safe_link "gemrc"
  safe_link "minttyrc"
  safe_link "screenrc"
  echo "Dotfile linking complete!"
}

dotfile_links

git_submodules () {
  echo "Setting up git submodules..."
  git submodule init
  git submodule update
  echo "Submodule initialization complete!"
}
git_submodules

vim_bundles () {
  echo "Setting up vim bundles..."
  vim +BundleInstall +qall
  echo "Vim bundle install complete!"
}
vim_bundles

git_ignore_local_mods () {
  echo "Ignoring future .local modifications..."
  git update-index --assume-unchanged vimrc.local
  git update-index --assume-unchanged vimrc.bundles.local
  echo "Local modification ignore complete!"
}
git_ignore_local_mods

#command -v curl >/dev/null 2>&1 || { echo "Installing curl (using sudo):"; sudo apt-get install curl; }
#command -v rvm >/dev/null 2>&1 || { echo "Installing rvm";
                                    #curl -sSL https://get.rvm.io | bash -s stable;
									#echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile; }
#source ~/.bash_profile
#rvm install ruby
#rvm use ruby

#gem install rake
#rake setup

#echo 'Building Command-T'
#cd dotvim/bundle/Command-T/ruby/command-t/
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
#rvm use system
#ruby extconf.rb
#make
#echo "...done!"

#echo 'Close existing terminals or `source ~/.bash_profile`'

