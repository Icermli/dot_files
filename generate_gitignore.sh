#!/bin/sh

# Update gitignore submodule
git submodule add git@github.com:github/gitignore.git
git submodule init
git submodule foreach git pull origin master

# Build gitignore_global, replacing the old one
cat gitignore/Global/* > .gitignore_global

# Don't ignore lib/
awk -i inplace '!/^lib\//' .gitignore_global

# Don't ignore jpg and html
awk -i inplace '!/^*.jpg/' .gitignore_global
awk -i inplace '!/^*.html/' .gitignore_global

# Don't ignore Python stuff like __init__.py
awk -i inplace '!/^\[_@\]*/' .gitignore_global

# Add more that suites my needs
echo .gdb_history >> .gitignore_global

echo ".gitignore_global updated."
