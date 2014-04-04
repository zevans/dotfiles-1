#!/bin/bash

# bash completion for capistrano tasks
#
# Generates a cache file (${HOME}/.cap_completion_cache) to avoid having to run cap -T for every 
# consecutive completion attempt. The cache file is renewed whenever completion is attempted from
# a different path, or after a timeout.

_cap_complete ()
{
  local cache_file="${HOME}/.cap_completion_cache"
  local cur=${COMP_WORDS[COMP_CWORD]}
  local prev=${COMP_WORDS[COMP_CWORD-1]}

  COMPREPLY=()

  # try to expand anything but options (starting with -) or named parameters (-s ___)
  if [[ $cur != -* ]] && [[ ! $prev =~ -[sS] ]]; then
    # refresh cache if it doesn't exist, is for the wrong path, or is too old
    if [[ ! -e $cache_file ]] || [[ $(pwd) != $(head -n1 $cache_file)* ]] || [ `find "$cache_file" -mmin +30` ] ; then
      echo "$(pwd)" >$cache_file
      cap -qT 2>/dev/null | grep '^cap' | awk '{print $2}' >>$cache_file
    fi
    COMPREPLY=( $(compgen -W "$(tail -c +2 $cache_file)" -- $cur) )
  fi

} 
complete -F _cap_complete cap

# allow completion of commands including colons
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
