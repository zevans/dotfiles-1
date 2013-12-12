# Quickstart
  - Build Tools for Platform (build essentials, etc.)
  - [ RVM ]( http://rvm.io ) with successful ruby compile
  - Configure Solarized for [ gnome-terminal ]( https://github.com/sigurdga/gnome-terminal-colors-solarized ) or [ iTerm2 ]( https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized ).  (or remove `altercation/vim-colors-solarized` from `vimrc`
  - Terminal set to login shell (if not possible, see patches on Elementary OS/Pantheon branch that switch sourcing order from `bash_profile` to `bashrc`; this is not the default due to integration with a Puppet configuration that overwrites .bashrc)
  - (Optional) Patched (powerline font)[https://github.com/Lokaltog/powerline-fonts] set in your terminal (or change `Powerline_symbols` in `vimrc` to `compatible`). Inconsolata-dz/Source Code Pro patches recommended for Linux/OS X, but Consolas.ttf patched works best for Cygwin/mintty

    git clone https://github.com/josephlogik/dotfiles
    cd dotfiles/
    ./setup.sh

# Install and configure for OSX
  - Install MacVim and mvim wrapper
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
    - Saucy (13.10)
  - Cygwin (no documentation)
  - Elementary OS Luna (see branch)

