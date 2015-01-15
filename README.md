# Quickstart

Install pre-requisites, then clone and run setup script.  **Setup script should be rerun on every subsequent update to ensure that any new dotfiles are configured correctly!**

## Ubuntu Linux
  - Set terminal of choice to login shell
  - Run the following in terminal of choice:

    ```
    sudo apt-get update
    sudo apt-get install git
    cd ~ && git clone https://github.com/josephlogik/dotfiles.git
    cd ~/dotfiles
    ./setup.sh
    ```

  - *(optional)* Configure Solarized for [gnome-terminal](https://github.com/sigurdga/gnome-terminal-colors-solarized) or your terminal of choice (xfce-terminal already pre-configured)
  - *(optional)* Setup patched [fonts for powerline](https://github.com/Lokaltog/powerline-fonts); Recommended font for Linux is Source Code Pro

  - *(optional)* For Linux virtual machines, you can pass your Git identity in to the machine via SSH if you modify your sshd config file's `AcceptEnv` directive as follows:

    ```
    # Allow client to pass locale and git environment variables
    AcceptEnv LANG LC_* GIT_*
    ```

## Mac OS X
  - Install [iTerm2](http://www.iterm2.com)
  - Install [Command Line Tools for XCode](https://developer.apple.com/downloads/index.action)
  - Install [MacVim](https://code.google.com/p/macvim/) and copy `mvim` CLI wrapper to `/usr/local/bin`
  - Install [XQuartz](http://xquartz.macosforge.org/) for Mountain Lion/Mavericks (X11 is included by default on Lion)
  - Add XQuartz/X11 to "Login Items" for your account under System Preferences
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

  - Run the following in iTerm2:

    ```
    cd ~ && git clone https://github.com/josephlogik/dotfiles.git
    cd ~/dotfiles
    ./setup.sh
    ```

  - *(optional)* Configure [Solarized for iTerm2]( https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized )
  - *(optional)* Setup patched [fonts for powerline](https://github.com/Lokaltog/powerline-fonts); Recommended font for OS X is Inconsolata-dz

## Cygwin on Windows
  - Install Cygwin and include git and wget packages
  - Install XWin server
  - For copy/paste integration through vim, with the same config as Linux/OS X, add a shortcut to the "Startup" group with the target

    ```
    C:\cygwin\\bin\run.exe -p /usr/X11R6/bin XWin -multiwindow -clipboard -silent-dup-error
    ```

  - Run the following in Cygwin terminal (mintty)

    ```
    cd ~ && git clone https://github.com/josephlogik/dotfiles.git
    cd ~/dotfiles
    ./setup.sh
    ```

  - *(optional)* Setup patched [fonts for powerline](https://github.com/Lokaltog/powerline-fonts); Recommended font for Cygwin/mintty is Consolas.ttf

# Features
  - Support for Ubuntu Linux, Mac OS X, and Cygwin on Windows eases cross platform work
  - Copy/paste integration inside vim/tmux, even bi-directional host-to-guest-VM using X11
  - Simple bash prompt with host display over SSH and directory colors
  - Git optimizations for settings and aliases and identity
  - Solarized colorscheme optimizations for tmux, gnome-terminal, and vim
  - Unified tmux/vim pane and split navigation with Ctrl-{h,j,k,l}
  - Vim
    - Copy/paste directly from vim to system clipboard (even inside a VM inside tmux)
    - Command-T for fuzzy file opening
    - Syntastic error checking support
    - Powerline with fancy symbols (enable in vimrc.local)
    - Exuberant ctags navigation plus Tagbar
    - Whitespace detection and highlighting
    - Run specs in tmux split using vim-dispatch and vim-rspec
    - Other sane defaults for searching, surround, and tpope plugins

## Customization
  - `~/.vimrc.local` for keybindings, and personal settings
  - `~/.gvimrc.local` for guifont and other personal gui settings
  - `~/.vimrc.bundles.local` for personal vim bundles
  - `~/dotfiles/git_identity.local` for git identity environment variables

# Tested OSes
  - Mac OS X
    - Lion
    - Mountain Lion
  - Ubuntu Linux
    - Lucid (10.04)
    - Precise (12.04)
    - Saucy (13.10)
  - Cygwin on Windows
