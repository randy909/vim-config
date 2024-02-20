#!/bin/bash

echo "Installing/Updating plugins"
vim +PlugInstall +qall > /dev/null 2>&1

if [ "$(uname)" == "MINGW*" ]; then
  echo "Skipping ycm and command-t for mingw"
  exit 0
fi

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
