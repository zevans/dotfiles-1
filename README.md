# Clone the repository into home directory and initialize
    git clone git@github.com:josephlogik/dotfiles.git
    cd dotfiles/
    git submodule init
    git submodule update

# Setup links from home directory as appropriate
    ln -s dotfiles/vimrc     .vimrc
    ln -s dotfiles/dotvim/   .vim
    ln -s dotfiles/tmux.conf .tmux.conf

# Inside of vim, run
    :BundleInstall

# Build Command-T with
    cd dotvim/bundle/command-t/ruby/command-t/
    ruby extconf.rb
    make
