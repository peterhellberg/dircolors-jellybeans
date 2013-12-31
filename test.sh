#!/bin/bash

EXAMPLE_DIR="/tmp/dircolors-jellybeans"

SCRIPT_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"

IMAGE_FILES=(
  i.jpg i.JPG i.jpeg i.gif i.bmp i.png i.svg i.svgz
  i.mng i.pcx i.yuv i.cgm i.emf i.eps i.CR2 i.ico
)

SPECIAL_FILES=(
  f.torrent f.xml f.nfo f.md f.conf f.yml
  Rakefile Gemfile README
)

function echoRed {
  echo -e "\e[0;31m$1\e[0m"
}

function echoGreen {
  echo -e "\e[0;32m$1\e[0m"
}

function echoBlue {
  echo -e "\e[1;34m$1\e[0m"
}

function removeExampleDirs {
  if [ -d "$EXAMPLE_DIR" ]; then
    echoRed "Removing $EXAMPLE_DIR/*"

    rm -r $EXAMPLE_DIR/images
    rm -r $EXAMPLE_DIR/special
  fi
}

function createExampleFiles {
  # First argument are the name
  name=$1

  # Shift the first argument
  shift

  # Rest of the arguments are files
  files=($@)

  echoGreen "Creating $EXAMPLE_DIR/$name"

  mkdir -p $EXAMPLE_DIR/$name

  for file in "${files[@]}"
  do
    touch $EXAMPLE_DIR/$name/$file
  done
}

function showExampleDirs {
  for name in "$@"
  do
    echoBlue "\n## $name"
    ls --color $EXAMPLE_DIR/$name
  done
}

function reloadDircolors {
  echo -e "\nReloading dircolors!  ゜ﾟ･ ヽ(⊙ ‿ ⊙)ノ ･゜ﾟ"

  eval $(dircolors $SCRIPT_DIR/dircolors.jellybeans)
}

# First clear the screen
clear

# Remove old examples
removeExampleDirs

# Create example files
createExampleFiles images ${IMAGE_FILES[@]}
createExampleFiles special ${SPECIAL_FILES[@]}

# Reload the dircolors
reloadDircolors

# Show all examples
showExampleDirs images special
