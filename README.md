# Clone the repository into home directory and initialize
    git clone git@github.com:josephlogik/dotfiles.git
    cd dotfiles/
    git submodule init
    git submodule update

# Setup links from home directory as appropriate
    ln -s dotfiles/bash_profile .bash_profile
    ln -s dotfiles/bashrc       .bashrc
    ln -s dotfiles/vimrc        .vimrc
    ln -s dotfiles/gvimrc       .gvimrc
    ln -s dotfiles/dotvim/      .vim
    ln -s dotfiles/tmux.conf    .tmux.conf
    ln -s ~/dotfiles/ackrc      ~/.ackrc

# Inside of vim, run
    :BundleInstall

# Build Command-T with
    cd dotvim/bundle/command-t/ruby/command-t/
    ruby extconf.rb
    make

# Install ack per platform
    sudo apt-get install ack-grep    # Debian/Ubuntu
    brew install ack                 # OS X with homebrew
