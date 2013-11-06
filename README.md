# Features
  - Support for OS X, Linux, and Cygwin eases cross platform work
  - Copy/paste integration inside vim/tmux, even host to guest VM using X11
  - Simple bash prompt with host display over SSH and git integration
  - Git optimizations for settings and aliases
  - Solarized colorscheme optimizations for tmux, gnome-terminal, and vim
  - Unified tmux/vim pane and split navigation with Ctrl-{h,j,k,l}
  - Vim
    - Copy/paste directly from vim to system clipboard (even inside a VM inside tmux)
    - Command-T for fuzzy file opening
    - Syntastic error checking support
    - Powerline with fancy symbols
    - Exuberant ctags navigation plus Tagbar
    - Whitespace detection and highlighting
    - Other sane defaults for searching, surround, and tpope plugins
    - Support for .vimrc.local for colorscheme changes, etc.

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
  - Build Tools for Platform (build essentials, etc.)
  - Homebrew (for OSX) with clean `brew doctor`
  - [ RVM ]( http://rvm.io ) with successful ruby compile
  - Configure Solarized for [ gnome-terminal ]( https://github.com/sigurdga/gnome-terminal-colors-solarized ) or [ iTerm2 ]( https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized ).  (or remove `altercation/vim-colors-solarized` from `vimrc`
  - Patched (powerline font)[https://github.com/Lokaltog/powerline-fonts] set in your terminal (or change `Powerline_symbols` in `vimrc` to `compatible`). Inconsolata-dz/Source Code Pro patches recommended for Linux/OS X, but Consolas.ttf patched works best for Cygwin/mintty
  - Terminal set to login shell (if not possible, see patches on Elementary OS/Pantheon branch that switch sourcing order from `bash_profile` to `bashrc`; this is not the default due to integration with a Puppet configuration that overwrites .bashrc)

# Clone the repository into home directory and initialize
    git clone https://github.com/josephlogik/dotfiles
    cd dotfiles/
    git submodule init
    git submodule update

# Setup links from home directory as appropriate

    #NOTE: delete .vim or other directories first!
    ln -sf ~/dotfiles/bash_profile  ~/.bash_profile
    ln -sf ~/dotfiles/bashrc        ~/.bashrc
    ln -sf ~/dotfiles/vimrc         ~/.vimrc
    ln -sf ~/dotfiles/vimrc.bundles ~/.vimrc.bundles
    ln -sf ~/dotfiles/gvimrc        ~/.gvimrc
    ln -sf ~/dotfiles/dotvim/       ~/.vim
    ln -sf ~/dotfiles/tmux.conf     ~/.tmux.conf
    ln -sf ~/dotfiles/ackrc         ~/.ackrc
    ln -sf ~/dotfiles/gitconfig     ~/.gitconfig
    ln -sf ~/dotfiles/bash/inputrc  ~/.inputrc
    ln -sf ~/dotfiles/gemrc         ~/.gemrc
    ln -sf ~/dotfiles/minttyrc      ~/.minttyrc
    ln -sf ~/dotfiles/screenrc      ~/.screenrc

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
  - Change the `*` register to `+` if vim copy/paste from X11 clipboard isn't working with `,y`

# Install and configure for OSX
  - Install MacVim and mvim wrapper
  - Install packages

    ```
    brew install ack tmux ctags xclip reattach-to-user-namespace
    ```
  - Install Command Line tools for OSX (developer.apple.com)
  - Install XQuartz for Mountain Lion
  - Add XQuartz/X11 to "Login Items" for your account
  - In XQuartz/X11 preferences, check all boxes under "Pasteboard" to enable copy/paste sync
  - Fix Command Line tools

    ```
    sudo xcode-select -switch /usr/bin
    sudo mv /usr/bin/xcrun /usr/bin/xcrun-orig
    Edit /usr/bin/xcrun and add:
        #!/bin/sh
        $@
    sudo chmod 755 /usr/bin/xcrun
    ```

# Install and configure for Windows/Cygwin
  - Install XWin server
  - For copy/paste integration through vim, with the same config as Linux/O X, add a shortcut to the "Startup" group with the target

    ```
    C:\cygwin\\bin\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error
    ```

# Configure git identity
    cp ~/dotfiles/bash/git_identity.example ~/dotfiles/bash/git_identity
    vim ~/dotfiles/bash/git_identity

  Note: this sets `GIT_` environment variables that can be accepted over SSH by
  a virtual machine to avoid setting this multiple places if your sshd config
  on the VM allows these through `AcceptEnv`

    # Allow client to pass locale and git environment variables
    AcceptEnv LANG LC_* GIT_*

# Inside of vim, run
    :BundleInstall

# Build Command-T extension
    cd ~/dotfiles/dotvim/bundle/command-t/ruby/command-t/
    rvm use system
    ruby extconf.rb
    make

