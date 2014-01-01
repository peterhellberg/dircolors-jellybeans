#!/usr/bin/env bash

function installRerun {
  if which gem >/dev/null; then
    install_rerun_cmd="gem install rerun"

    echo "Installing Rerun: $install_rerun_cmd"

    $install_rerun_cmd
  else
    echo "You need to install Ruby (gem command missing)"
  fi
}

function runTest {
  rerun -x -b -p "**/{dircolors.*,*.sh}" -- ./test/test.sh
}

if [ "$(uname -s)" != "Linux" ]; then
  if ! which gdircolors >/dev/null; then
    if which brew >/dev/null; then
      echo "Installing GNU coreutils (gdircolors, gls)"

      brew install coreutils
    else
      echo "You must install GNU coreutils"
      exit
    fi
  fi
fi

if which rerun >/dev/null; then
  runTest
else
  installRerun

  sleep 4
  runTest
fi
