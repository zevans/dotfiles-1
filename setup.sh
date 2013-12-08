command -v curl >/dev/null 2>&1 || { echo "Installing curl (using sudo):"; sudo apt-get install curl; }
command -v rvm >/dev/null 2>&1 || { echo "Installing rvm";
                                    curl -sSL https://get.rvm.io | bash -s stable;
									echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile; }
source ~/.bash_profile
rvm install ruby
rvm use ruby
gem install rake
rake setup
