#!/bin/bash

if [[ ! -d plugged ]] ; then
  echo "ERROR: Plugins not installed!"
  echo "Start vim and run :PlugInstall then try this script again."
  exit 1
fi

if [[ ! -e plugged/YouCompleteMe/third_party/ycmd/ycm_core.so ]] ; then
  echo "Installing YouCompleteMe"
  pushd plugged/YouCompleteMe
  python install.py
  popd
fi

if [[ ! -e plugged/Command-T/ruby/command-t/ext.so ]] ; then
  echo "Installing Command-T"
  pushd plugged/Command-T/ruby/command-t
  ruby extconf.rb
  make
  popd
fi
