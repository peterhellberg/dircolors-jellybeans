#!/usr/bin/env bash

function onlyRunTestsUnderLinux {
  if [ "$(expr substr $(uname -s) 1 5)" != "Linux" ]; then
    echo "Not running under Linux, aborting tests."
    exit
  fi
}

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

onlyRunTestsUnderLinux

if which rerun >/dev/null; then
  runTest
else
  installRerun

  sleep 4
  runTest
fi
