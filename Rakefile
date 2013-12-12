  #TODO: make this check for the line instead of just adding repeatedly
  system 'echo "let g:ackprg=\"ack-grep -H --nocolor --nogroup --column\"" >> vimrc.local'
  #TODO: validate this override works and doesn't break VMs
  system 'echo "noremap <leader>y \"+y" >> vimrc.local'
  system 'echo "noremap <leader>yy \"+Y" >> vimrc.local'
  system 'echo "noremap <leader>p \"+p" >> vimrc.local'
  system "mv ~/.profile ~/.profile-disabled_by_dotfiles"
end
