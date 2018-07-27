#!/usr/bin/env zsh

if (( $+commands[dircolors] )); then
  eval $(dircolors ${${(%):-%x}:a:h}/dircolors.jellybeans )
else
  if (( $+commands[gdircolors] )); then
    eval $(gdircolors ${${(%):-%x}:a:h}/dircolors.jellybeans )
  fi

fi

export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
