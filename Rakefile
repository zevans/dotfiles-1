task :default => [:setup]

task :setup => [:system, :tmux, :submodules, :links, :git, :vim]


task :system do
  Rake::Task["system_#{os_type}"].invoke
end

task :system_linux do
  next unless ENV["_system_name"] == "Ubuntu"
  puts "Setting up prequisites... (requires sudo password)"
  system "sudo apt-get install #{linux_packages}"

  #TODO: make this check for the line instead of just adding repeatedly
  system 'echo "let g:ackprg=\"ack-grep -H --nocolor --nogroup --column\"" >> vimrc.local'
  #TODO: validate this override works and doesn't break VMs
  system 'echo "noremap <leader>y \"+y" >> vimrc.local'
  system 'echo "noremap <leader>yy \"+Y" >> vimrc.local'
  system 'echo "noremap <leader>p \"+p" >> vimrc.local'
  system "mv ~/.profile ~/.profile-disabled_by_dotfiles"
end

task :system_osx do
  #TODO: homebrew installation
end

task :system_windows do
  #TODO install apt-cyg and validate screen install
end

task :system_unknown do
  puts "Unknown system, install pre-requisites manually"
end

task :tmux do
  command = case os_type
             when "linux"
               #TODO: tmux installation of 1.8 for lucid/precise
               "sudo apt-get install tmux"
             when "osx"
               "brew update tmux"
             when "windows"
               "apt-cyg install screen"
             end
  system command
end

task :vim do
  puts "Installing vim bundles..."
  system "vim +BundleInstall +qall"
  puts "...done!"
end

task :submodules do
  puts "Setting up submodules..."
  system "git submodule init"
  system "git submodule update"
  puts "...done!"
end

task :links do
  puts "Setting up dotfile links..."
  #TODO: consider using --backup and --interactive flags
  system "ln -sf ~/dotfiles/bash_profile        ~/.bash_profile"
  system "ln -sf ~/dotfiles/bashrc              ~/.bashrc"
  system "ln -sf ~/dotfiles/vimrc               ~/.vimrc"
  system "ln -sf ~/dotfiles/vimrc.local         ~/.vimrc.local"
  system "ln -sf ~/dotfiles/vimrc.bundles       ~/.vimrc.bundles"
  system "ln -sf ~/dotfiles/vimrc.bundles.local ~/.vimrc.bundles.local"
  system "ln -sf ~/dotfiles/gvimrc              ~/.gvimrc"
  #TODO: avoid adding links of links
  system "ln -sf ~/dotfiles/dotvim/             ~/.vim"
  system "ln -sf ~/dotfiles/tmux.conf           ~/.tmux.conf"
  system "ln -sf ~/dotfiles/ackrc               ~/.ackrc"
  system "ln -sf ~/dotfiles/gitconfig           ~/.gitconfig"
  system "ln -sf ~/dotfiles/bash/inputrc        ~/.inputrc"
  system "ln -sf ~/dotfiles/gemrc               ~/.gemrc"
  system "ln -sf ~/dotfiles/minttyrc            ~/.minttyrc"
  system "ln -sf ~/dotfiles/screenrc            ~/.screenrc"
  puts "...done!"
end

task :git do
  puts "Ignoring future .local modifications..."
  system "git update-index --assume-unchanged vimrc.local"
  system "git update-index --assume-unchanged vimrc.bundles.local"
  puts "...done!"
end

def os_type
  return "windows" if ENV["OS"] =~ /windows/i
  return "linux"   if ENV["_system_type"] =~ /linux/i
  return "osx"     if RUBY_PLATFORM =~ /darwin/i
  return "unknown"
end

def linux_packages
  %w{ack-grep exuberant-ctags xclip vim-gtk ruby ruby1.9.1-dev}.join(" ")
end
