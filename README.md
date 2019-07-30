# dot-files
A bunch of dot files that work accross different platforms.

## tmux
The .tmux.conf is a configuration file for tmux. To use, make a symlink of this file under $HOME.

See [this video](https://youtu.be/JXwS7z6Dqic) for more information about tmux.

### TPM

Tmux plugin manager (TPM) is used for some plugins of Tmux. To use it, run
```
git submodule update --init .tumx/plugins/tpm
```
then within tmux, press `Prefix I` to finish setup.

## spacemacs

Install emacs on Mac, as recommended by Spacemacs developers:
```bash
$ brew tap d12frosted/emacs-plus
$ brew install emacs-plus
$ brew linkapps emacs-plus
```

In `.spacemacs` file, load `spacemacs/user-init.el` in 
`dotspacemacs/user-init ()` and load `spacemacs/user-config.el`
in `dotspacemacs/user-config ()`.

## neovim
The .nvimrc is a configuration file for neovim. To use it, first install 
[vim-plug](https://github.com/junegunn/vim-plug) 
following the instructions therein, then make a symlink of this file under $HOME.

After that, start nvim and run
```vim
PlugUpdate | PlugUpgrade
```

A good resource for learning vim is Steve's [Learn Vimscript the Hard Way](http://learnvimscriptthehardway.stevelosh.com/).

## ctags

The .ctags is to maek ctags ignore some common directories. To use is, make a symlink as $HOME/.ctags.

## clang-format

There is a .clang-format file that is used to format C++ code. To use it, make a symlink as $HOME/.clang-format and pass -style=file to clang-format

## MacOS

The .bashrc here also works for MacOS. Just add 

```bash
source $HOME/.bashrc
```
to `.bash_profile`
