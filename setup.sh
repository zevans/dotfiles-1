command -v curl >/dev/null 2>&1 || { echo "Installing curl (using sudo):"; sudo apt-get install curl; }
command -v rvm >/dev/null 2>&1 || { echo "Installing rvm";
                                    curl -sSL https://get.rvm.io | bash -s stable;
									echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> ~/.bash_profile; }
source ~/.bash_profile
rvm install ruby
rvm use ruby

gem install rake
rake setup

echo 'Building Command-T'
cd dotvim/bundle/Command-T/ruby/command-t/
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
rvm use system
ruby extconf.rb
make
echo "...done!"

echo 'Close existing terminals or `source ~/.bash_profile`'
