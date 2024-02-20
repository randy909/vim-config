#!/bin/bash

# This script seems to hang even on the install step on windows so don't use it
if [[ $(uname) == MINGW* ]]; then
  echo "Don't use this script in mingw, just run :PlugInstall from vim"
  exit -1
fi

echo "Installing/Updating plugins"
vim +PlugInstall +qall > /dev/null 2>&1

if [[ ! -e plugged/YouCompleteMe/third_party/ycmd/ycm_core.so ]] ; then
  echo "Compiling YouCompleteMe"
  pushd plugged/YouCompleteMe
  python3 install.py
  popd
fi

if [[ ! -e plugged/Command-T/ruby/command-t/ext/command-t/ext.bundle ]] ; then
  echo "Compiling Command-T"
  pushd plugged/Command-T
  rake make
  popd
fi
