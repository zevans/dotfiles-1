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

tmux_package=tmux-1.8.tar.gz
tmux_base_url=http://downloads.sourceforge.net/tmux
tmux_directory=tmux-1.8

linux_build_tmux () {
  echo "Installing tmux from source..."
  if linux_check_pkg tmux; then sudo apt-get purge -y tmux; fi
  if command -v tmux >/dev/null 2>&1; then
	echo "Compiled tmux found... skipping"
  else
	linux_install_pkg libevent-dev
	linux_install_pkg libncurses5-dev
	if [ -z "$1" ]; then flags=""; else flags=$1; fi
	wget $tmux_base_url/$tmux_package -O /tmp/$tmux_package
	cwd=`pwd`
	cd /tmp
	tar xfz $tmux_package
	cd $tmux_directory
	./configure $flags
	make
	sudo make install
	cd $cwd
	echo "tmux install complete!"
  fi
}

linux_tmux_lucid () {
  if [ -a /usr/local/lib/libevent-2.0.so.5 ]; then
	echo "Compiled libevent found... skipping"
  else
	libevent_package=libevent-2.0.21-stable.tar.gz
	libevent_base_url=https://github.com/downloads/libevent/libevent
	libevent_directory=libevent-2.0.21-stable
	echo "Installing libevent for tmux..."
	wget $libevent_base_url/$libevent_package -O /tmp/$libevent_package
	cwd=`pwd`
	cd /tmp
	tar xfz $libevent_package
	cd $libevent_directory
	./configure
	make
	sudo make install
	cd $cwd
	echo "libevent install complete!"
  fi
  linux_build_tmux --enable-static
}

linux_tmux () {
  if command -v tmux >/dev/null 2>&1; then
	echo "tmux detected... skipping"
  else
	echo "Installing tmux from apt..."
	sudo apt-get install tmux -y
	echo "tmux install complete!"
  fi
}

linux_setup () {

  # Return unless specific version is supported
  if cat /etc/lsb-release | grep -q -e '10.04'; then
    echo "Detected Ubuntu 10.04 Lucid..."
	linux_version="lucid"
  elif cat /etc/lsb-release | grep -q -e '12.04'; then
    echo "Detected Ubuntu 12.04 Precise..."
	linux_version="precise"
  elif cat /etc/lsb-release | grep -q -e '13.10'; then
    echo "Detected Ubuntu 13.10 Saucy..."
	linux_version="saucy"
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
  linux_install_pkg "wget"
  linux_install_pkg "curl"
  echo -e "Package installation complete!\n"

  case $linux_version in
	lucid   ) linux_tmux_lucid   ;;
	precise ) linux_build_tmux   ;;
	default ) linux_tmux         ;;
esac
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

cygwin_setup () {
  echo "Not implemented; install apt-cyg"
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
  ln -sfn "$HOME/dotfiles/$1" "$HOME/.$target"
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

build_commandt () {
  echo 'Building Command-T...'
  if [ -e dotvim/bundle/Command-T/ruby/command-t/ ]; then
	cd dotvim/bundle/Command-T/ruby/command-t/
  elif [ -e dotvim/bundle/command-t/ruby/command-t/ ]; then
	cd dotvim/bundle/command-t/ruby/command-t
  else
	echo "Cannot find Command-T bundle... exiting!"
	return
  fi
  if [[ -e ext.o && -e match.o && -e matcher.o ]]; then
	echo "Compiled Command-T found... skipping"
  else
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
	rvm use system
	ruby extconf.rb
	make
	echo "Build complete!"
  fi
}
build_commandt

echo 'Close existing terminals or `source ~/.bash_profile`'

#command -v curl >/dev/null 2>&1 || { echo "Installing curl (using sudo):"; sudo apt-get install curl; }
#command -v rvm >/dev/null 2>&1 || { echo "Installing rvm";
                                    #curl -sSL https://get.rvm.io | bash -s stable;
									#echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile; }
#source ~/.bash_profile
#rvm install ruby
#rvm use ruby

#gem install rake
#rake setup

