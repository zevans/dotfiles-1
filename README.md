# Tested OSes
    - OS X
      - Lion
      - Mountain Lion
    - Ubuntu
      - Lucid (10.04)
      - Precise (12.04)
    - Cygwin (no documentation)
    - Elementary OS Luna (see branch)

# Prerequisites
  - Build Tools for Platform
  - Homebrew (for OSX) with clean `brew doctor`
  - [ RVM ]( http://rvm.io ) with successful ruby compile

# Clone the repository into home directory and initialize
    git clone https://github.com/josephlogik/dotfiles
    cd dotfiles/
    git submodule init
    git submodule update

# Setup links from home directory as appropriate

    #NOTE: delete .vim or other directories first!
    ln -sf ~/dotfiles/bash_profile ~/.bash_profile
    ln -sf ~/dotfiles/bashrc       ~/.bashrc
    ln -sf ~/dotfiles/vimrc        ~/.vimrc
    ln -sf ~/dotfiles/gvimrc       ~/.gvimrc
    ln -sf ~/dotfiles/dotvim/      ~/.vim
    ln -sf ~/dotfiles/tmux.conf    ~/.tmux.conf
    ln -sf ~/dotfiles/ackrc        ~/.ackrc
    ln -sf ~/dotfiles/gitconfig    ~/.gitconfig
    ln -sf ~/dotfiles/bash/inputrc ~/.inputrc
    ln -sf ~/dotfiles/gemrc        ~/.gemrc
    ln -sf ~/dotfiles/minttyrc     ~/.minttyrc
    ln -sf ~/dotfiles/screenrc     ~/.screenrc

# Install and configure for Linux
  - Install packages

    ```
    sudo apt-get install ack-grep exuberant-ctags xclip vim-gtk ruby
    ```
  - Change .vimrc ack command by uncommenting the ack-grep line
  - Install tmux 1.8

    ```
    sudo apt-get purge tmux -y
    sudo apt-get install libevent-dev ncurses-dev -y
    wget http://downloads.sourceforge.net/tmux/tmux-1.8.tar.gz
    tar xfz tmux-1.8.tar.gz
    cd tmux-1.8
    ./configure
    make
    sudo make install
    ```

# Install and configure for OSX
  - Install packages

    ```
    brew install ack tmux ctags xclip reattach-to-user-namespace
    ```
  - Install Command Line tools for OSX (developer.apple.com)
  - Fix Command Line tools

    ```
    sudo xcode-select -switch /usr/bin
    sudo mv /usr/bin/xcrun /usr/bin/xcrun-orig
    Edit /usr/bin/xcrun and add:
        #!/bin/sh
        $@
    sudo chmod 755 /usr/bin/xcrun
    ```

# Configure git identity
    cp ~/dotfiles/bash/git_identity.example ~/dotfiles/bash/git_identity
    vim ~/dotfiles/bash/git_identity

# Inside of vim, run
    :BundleInstall

# Build Command-T extension
    cd ~/dotfiles/dotvim/bundle/command-t/ruby/command-t/
    rvm use system
    ruby extconf.rb
    make

