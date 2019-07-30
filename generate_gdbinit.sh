#!/bin/sh

# Update gitignore submodule
git submodule add https://github.com/cyrus-and/gdb-dashboard.git
git submodule init
git submodule foreach git pull origin master

# Build gitignore_global, replacing the old one
cat gdb-dashboard/.gdbinit > .gdbinit

# For mac, requires GNU sed (gsed)
if [ "$(uname)" == "Darwin" ]; then
  echo "Doing MacOS magic"
  gsed -i '1 i\set startup-with-shell off' .gdbinit
fi

echo ".gdbinit updated."
