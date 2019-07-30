#!/bin/bash

DOT_DIR=$(pwd)
echo "==================================="
echo Welcome to xywei"'"s dot files!
echo "==================================="
DOT_FILES=(\
  ".bashrc"\
  ".tmux.conf"\
  ".tmux-osx.conf"\
  ".tmux/plugins/tpm"\
  ".ctags"\
  ".gitconfig"\
  ".gitignore_global"\
  ".gdbinit"\
  ".inputrc"\
  ".latexmkrc"\
  ".jrnl_config"\
  ".gdbinit"\
  ".clang-format"\
  ".dircolors"\
  ".config/nvim"\
  ".TeXmacs/plugins"\
  ".TeXmacs/progs"\
  ".emacs.d/init.el"\
  ".emacs.d/JxW_config"\
  "cli-utils"
  )

# Option to update .gitignore
while true; do
  read -p "Do you wish to update .gitignore_global?" yn
  case $yn in
    [Yy]* ) sh generate_gitignore.sh; break;;
    [Nn]* ) echo "Skipping.."; break;;
    * ) echo "Please answer [y]es or [n]o.";;
  esac
done

# Option to update .gdbinit
while true; do
  read -p "Do you wish to update .gdbinit?" yn
  case $yn in
    [Yy]* ) sh generate_gdbinit.sh; break;;
    [Nn]* ) echo "Skipping.."; break;;
    * ) echo "Please answer [y]es or [n]o.";;
  esac
done

# Setup a single entry
function setup_entry {
entry=$1
echo "-----------------------------------"
echo Setting up $entry..
if [ -e $HOME/"$entry" ];
then
  if [ -L $HOME/"$entry" ];
  then
    if [ "$(readlink $HOME/$entry)" = $DOT_DIR/"$entry" ];
    then
      echo "Target $HOME/$entry symlink already setup! Skipping.."
      return 0
    else
      echo "Target $HOME/$entry symlink exists but pointing to another file!"
      echo " >> $HOME/$entry is pointing to $(readlink $HOME/$entry)"
      echo " >> But I am trying to setup symlink to $DOT_DIR/$entry"
      while true; do
        read -p "Do you wish to force re-linking this entry?" yn
        case $yn in
          [Yy]* ) rm -f $HOME/"$entry"; ln -s $DOT_DIR/"$entry" $HOME/"$entry"; echo "Done."; break;;
          [Nn]* ) echo Skipping..; break;;
          * ) echo "Please answer [y]es or [n]o.";;
        esac
      done
    fi
  else
    echo "Target $HOME/$entry exists and is not a symlin!"
    echo "Please check out that file, make your decisions, and re-run this script."
    while true; do
      read -p "Do you wish to skip this one and continue installing the rest?" yn
      case $yn in
        [Yy]* ) echo Skipping..; break;;
        [Nn]* ) echo Exiting..; exit 1;;
        * ) echo "Please answer [y]es or [n]o.";;
      esac
    done
  fi
else
  if [ -L $HOME/"$entry" ];
  then
    echo "Target $HOME/$entry exists as a broken symlink!"
    echo " >> $HOME/$entry is pointing to $(readlink $HOME/$entry)"
    read -p "Force re-linking this entry to $DOT_DIR/$entry?" yn
    while true; do
      case $yn in
        [Yy]* ) rm -f $HOME/"$entry"; ln -s $DOT_DIR/"$entry" $HOME/"$entry"; echo "Done."; break;;
        [Nn]* ) echo Skipping..; break;;
        * ) echo "Please answer [y]es or [n]o.";;
      esac
    done
  else
    ln -s $DOT_DIR/"$entry" $HOME/"$entry"
    echo "Done."
  fi
  return
fi
}

if [ -f $DOT_DIR/README.md ];
then
  echo Installing dot files..
else
  echo ERROR: Install.sh must be ran from under dot-files/. 1>&2
  exit 1
fi

mkdir -p $HOME/.config
mkdir -p $HOME/.emacs.d
mkdir -p $HOME/.tmux/plugins

for i in "${DOT_FILES[@]}"
do
  setup_entry $i
done

echo Finished! May the 4th B wiz U!
