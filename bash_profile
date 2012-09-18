if [ -f ~/.bashrc ]; then
	source ~/.bashrc
fi

if [ $OSTYPE==darwin11 ]; then
	alias vim="mvim -v"
fi
