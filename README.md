# Clone the repository into home directory and initialize
    git clone git@github.com:josephlogik/dotfiles.git
    cd dotfiles/
    git submodule init
    git submodule update

# Setup links from home directory as appropriate
    ln -sf ~/ dotfiles/bash_profile ~/.bash_profile
    ln -sf ~/ dotfiles/bashrc       ~/.bashrc
    ln -sf ~/ dotfiles/vimrc        ~/.vimrc
    ln -sf ~/ dotfiles/gvimrc       ~/.gvimrc
    ln -sf ~/ dotfiles/dotvim/      ~/.vim
    ln -sf ~/ dotfiles/tmux.conf    ~/.tmux.conf
    ln -sf ~/dotfiles/ackrc         ~/.ackrc
    ln -sf ~/dotfiles/gitconfig     ~/.gitconfig
    ln -sf ~/dotfiles/inputrc       ~/.inputrc

# Inside of vim, run
    :BundleInstall

# Build Command-T with
    cd dotvim/bundle/command-t/ruby/command-t/
    # Note: use system ruby if available
    # (rvm installed 1.9.3 also known to work for OSX 10.7/10.8 and Ubuntu 10.04/12.04/12.10)
    ruby extconf.rb
    make

# Install ack per platform
    sudo apt-get install ack-grep    # Debian/Ubuntu
    brew install ack                 # OS X with homebrew

# Configure git identity
    cp ~/dotfiles/bash/git_identity.example ~/dotfiles/bash/git_identity
    vim ~/dotfiles/bash/git_identity

# Setup OSX tmux copy wrapper
    cd ~/dotfiles/osx/tmux-MacOSX-pasteboard
    make reattach-to-user-namespace && cp reattach-to-user-namespace ~/bin

