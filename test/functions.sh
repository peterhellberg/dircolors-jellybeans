#!/usr/bin/env bash

if which gdircolors >/dev/null; then
  CMD_DIRCOLORS=gdircolors
  CMD_LS=gls
else
  CMD_DIRCOLORS=dircolors
  CMD_LS=ls
fi

function clearScreenWithTime {
  clear
  date
}

function removeExampleDirs {
  if [ -d "$EXAMPLE_DIR" ]; then
    echoRed "Removing example dirs…"

    for example in "${EXAMPLES[@]}"
      do if [ -d "$EXAMPLE_DIR/$example" ]; then
        rm -r $EXAMPLE_DIR/$example
      fi
    done
  fi
}

function createExampleDirs {
  echoGreen "Creating example dirs…"

  for name in "${EXAMPLES[@]}"
    do mkdir -p $EXAMPLE_DIR/$name
  done
}

function createAllExampleFiles {
  for name in "${EXAMPLES[@]}"
  do
    upper=`echo "$name" | tr '[:lower:]' '[:upper:]'`
    array="${upper}_FILES"
    subst="$array[@]"

    createExampleFiles $name ${!subst}
  done
}

function createExampleFiles {
  # First argument are the example name
  name=$1

  # Shift the first argument
  shift

  # Rest of the arguments are files
  files=($@)

  for file in "${files[@]}"
    do touch $EXAMPLE_DIR/$name/$file
  done
}

function reloadDircolors {
  GENERATED_DIRCOLORS=$EXAMPLE_DIR.generated

  cat $SCRIPT_DIR/../dircolors.jellybeans \
      $SCRIPT_DIR/dircolors.all_colors > $GENERATED_DIRCOLORS

  printf "\nReloading dircolors!  ゜ﾟ･ ヽ(⊙ ‿ ⊙)ノ ･゜ﾟ\n\n"

  eval $($CMD_DIRCOLORS $GENERATED_DIRCOLORS)
}

function listDir {
  $CMD_LS --color -AF $1
}

COLUMNS=`tput cols`

function showDir {
  NAME_LENGTH=${#1}
  COUNT=$((COLUMNS-NAME_LENGTH-3))

  printf "\e[1;30m— $1 "
  printf '%0.s—' $(seq 1 $COUNT)
  printf "\e[0m"

  if [ -n "$2" ]; then
    listDir $2
  else
    listDir $EXAMPLE_DIR/$1
  fi
}

function showRealDir {
  showDir $1 $1
}

function showExampleDirs {
  for name in "${EXAMPLES[@]}"
    do showDir $name
  done
}

function echoRed {
  printf "$3\e[0;31m$1\e[0m$2\n"
}

function echoGreen {
  printf "$3\e[0;32m$1\e[0m$2\n"
}

function echoBlue {
  printf "$3\e[1;34m$1\e[0m$2\n"
}

function createSpecialFiles {
  SPECIAL_DIR=$EXAMPLE_DIR/special

  echoBlue "Creating special files (symlinks, etc)"

  createSpecialDir   DIR
  createSpecialFile  NORMAL
  symlinkSpecialFile NORMAL symlink
  orphanSpecialFile  ORPHAN
  chmodSpecialDir    STICKY +t
  chmodSpecialDir    OTHER_WRITABLE o+w
  chmodSpecialDir    STICKY_OTHER_WRITABLE +t,o+w
  chmodSpecialFile   SETUID u+s
  chmodSpecialFile   SETGID g+s
  chmodSpecialFile   EXEC +x
}

function createSpecialDir {
  mkdir -p $SPECIAL_DIR/$1
}

function createSpecialFile {
  touch $SPECIAL_DIR/$1
}

function symlinkSpecialFile {
  ln -sf $SPECIAL_DIR/$1 $SPECIAL_DIR/$2
}

function orphanSpecialFile {
  ORPHAN_TARGET=$SPECIAL_DIR/$1_TARGET

  touch $ORPHAN_TARGET

  ln -sf $ORPHAN_TARGET $SPECIAL_DIR/$1

  rm $ORPHAN_TARGET
}

function chmodSpecialDir {
  mkdir $SPECIAL_DIR/$1
  chmodSpecial $1 $2
}

function chmodSpecialFile {
  touch $SPECIAL_DIR/$1
  chmodSpecial $1 $2
}

function chmodSpecial {
  chmod $2 $SPECIAL_DIR/$1
}
