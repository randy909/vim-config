#!/bin/bash

echo "Installing/Updating plugins"
vim +PlugInstall +qall > /dev/null 2>&1

if [[ ! -e plugged/YouCompleteMe/third_party/ycmd/ycm_core.so ]] ; then
  echo "Compiling YouCompleteMe"
  pushd plugged/YouCompleteMe
  python install.py
  popd
fi

if [[ ! -e plugged/Command-T/ruby/command-t/ext.so ]] ; then
  echo "Compiling Command-T"
  pushd plugged/Command-T/ruby/command-t
  ruby extconf.rb
  make
  popd
fi
