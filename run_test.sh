#!/usr/bin/env bash
#
# First install rerun: gem install rerun
#

function runTest {
  rerun -x -b -p "**/{dircolors.*,*.sh}" -- ./test/test.sh
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

if which rerun >/dev/null; then
  runTest
else
  installRerun
  sleep 5
  runTest
fi
