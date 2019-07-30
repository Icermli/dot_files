# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# vi mode
set -o vi
export VISUAL=vim

# when set, use a consistent, time-independent
# color theme across terminal, vim and tmux
# unset COLORTHEME
export COLORTHEME=dark
#export COLORTHEME=light

alias reload='source ~/.bashrc'

# Detect platform
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='darwin'
 fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# There is a bug in MacOS at the moment.
# See https://serverfault.com/questions/422908/how-can-i-prevent-the-warning-no-xauth-data-using-fake-authentication-data-for
#if [ "$platform" == 'darwin' ]; then
#  dispdir=`dirname $DISPLAY`
#  dispfile=`basename $DISPLAY`
#  dispnew="$dispdir/:0"
#  if [ -e $DISPLAY -a "$dispfile" = "org.x:0" ]; then
#    mv $DISPLAY $dispnew
#  fi
#  export DISPLAY=$dispnew
#fi

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
esac

# For MacOS, add bash completions under Homebrew
if [[ $platform == 'darwin' ]]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# For MacOS this is the root folder where all globally
# installed node packages will  go
# https://gist.github.com/rcugut/c7abd2a425bb65da3c61d8341cd4b02d
if [[ $platform == 'darwin' ]]; then
  export NPM_PACKAGES="/usr/local/npm_packages"
  export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
  # add to PATH
  export PATH="$NPM_PACKAGES/bin:$PATH"
fi

# XMind issue on Linux
# https://xmind.desk.com/customer/portal/questions/15880703-xmind7-very-slow-compared-to-version-6
if [[ $platform == 'linux' ]]; then
  export SWT_GTK3=0
fi

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    export PS1="\[\033[38;5;12m\][\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;12m\]@\[$(tput sgr0)\]\[\033[38;5;7m\]\h\[$(tput sgr0)\]\[\033[38;5;12m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]: \[$(tput sgr0)\]\[\033[38;5;7m\]\w\[$(tput sgr0)\]\[\033[38;5;12m\]>\[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
else
    export PS1="[\u@\h]: \w>\\$"
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# if [[ `date +"%k"` -lt 18 ]] && [[ `date +"%k"` -gt 6  ]]; then
#   if [ -f ~/cli-utils/promptline_light ]; then
#     source ~/cli-utils/promptline_light
#   fi
#   if [ -f ~/.taskrc_light ]; then
#     export TASKRC=$HOME/.taskrc_light
#   fi
# else
#   if [ -f ~/cli-utils/promptline_dark ]; then
#     source ~/cli-utils/promptline_dark
#   fi
#   if [ -f ~/.taskrc_dark ]; then
#     export TASKRC=$HOME/.taskrc_dark
#   fi
# fi
# 
# if [ "$COLORTHEME" = dark ]; then
#   if [ -f ~/cli-utils/promptline_dark ]; then
#     source ~/cli-utils/promptline_dark
#   fi
#   if [ -f ~/.taskrc_dark ]; then
#     export TASKRC=$HOME/.taskrc_dark
#   fi
# elif [ "$COLORTHEME" = light ]; then
#   if [ -f ~/cli-utils/promptline_light ]; then
#     source ~/cli-utils/promptline_light
#   fi
#   if [ -f ~/.taskrc_light ]; then
#     export TASKRC=$HOME/.taskrc_light
#   fi
# fi
# 
# overwrite with external promptline
if [ -f ~/cli-utils/promptline ]; then
  source ~/cli-utils/promptline
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    export PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add color database in ~/.dircolors for self-defined themes
[ -e "/etc/DIR_COLORS" ] && DIR_COLORS="/etc/DIR_COLORS"
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""
if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b $DIR_COLORS`"
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Always print out compile commands
alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1'

# Enable custom password-store extensions
export PASSWORD_STORE_ENABLE_EXTENSIONS=true

# For GPG >= 2.1.0
export GPG_TTY=$(tty)

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# brew install bash-completion
if [[ $platform == 'darwin' ]]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# simple tmsu bash completion
# must be sourced after bash_completion
# https://github.com/oniony/TMSU/issues/78
if [ -f $HOME/cli-utils/tmsu_bash_completion ]; then
  . $HOME/cli-utils/tmsu_bash_completion
fi

export TERM=screen-256color

# An alias for starting GUI on Linux
alias desk="startx --extension glx"

# Just use neovim
alias vim="nvim"
alias vs="nvim -S"
alias vi="nvim"

# Run emacs with --no-window-system
alias emacs="emacs -nw"

alias ta="tmux attach -t"

# https://raimue.blog/2013/01/30/tmux-update-environment/
if [ -f $HOME/cli-utils/tmux.bash ]; then
  source $HOME/cli-utils/tmux.bash
fi

alias py="DYLD_LIBRARY_PATH=$HOME/opt/lib PYOPENCL_CTX=':' python"
alias pt="DYLD_LIBRARY_PATH=$HOME/opt/lib PYOPENCL_CTX=':' pytest"

# Disable middle click paste
if hash xmodmap 2>/dev/null; then
    xmodmap -e "pointer = 1 6 3 4 5 2" 2>/dev/null
fi

# Load Spack if it is under $HOME
export SPACK_ROOT=$HOME/spack
if [ -f ${SPACK_ROOT}/share/spack/setup-env.sh ]; then
  #echo Loading spack..
  . ${SPACK_ROOT}/share/spack/setup-env.sh
  #echo Loading spack.. Done.
  #echo Loading environment modules..
  MODULES_HOME=`spack location -i environment-modules`
  source ${MODULES_HOME}/Modules/init/bash
  #echo Loading environment modules.. Done.
fi

# echo Loading mpi..
# spack load mpi
# echo Loading mpi.. Done.

# echo Loading dealii..
# spack load dealii
# echo Loading dealii.. Done.

# Alias definitions.
# You may want to put all your local additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Anaconda/Miniconda using alias instead of adding to PATH
# See https://github.com/conda/conda/issues/4552
#if [ -d ~/miniconda3/bin ]; then
  # echo "Using miniconda3 via aliases"
  #alias act="source $HOME/miniconda3/bin/activate"
  #alias dact="source $HOME/miniconda3/bin/deactivate"
 # alias conda="$HOME/miniconda3/bin/conda"
#else
 # if [ -d ~/anaconda/bin ]; then
    # echo "Using anaconda via aliases"
   # alias act="source $HOME/anaconda/bin/activate"
  #  alias dact="source $HOME/anaconda/bin/deactivate"
 #   alias conda="$HOME/anaconda/bin/conda"
  # else
    # echo "Conda not found"
 # else
#    if [ -d ~/anaconda3/bin ]; then
      # echo "Using anaconda via aliases"
      #alias act="source $HOME/anaconda3/bin/activate"
      #alias dact="source $HOME/anaconda3/bin/deactivate"
     # alias conda="$HOME/anaconda3/bin/conda"
#    fi
#  fi
#fi

# bash-insulter (requires bash 4 to work)
# For MacOS X, install bash 4 from `homebrew install bash`,
# add /usr/local/bin/bash to /etc/shells, and run `chsh -s /usr/local/bin/bash`
if [ "$platform" == 'linux' ]; then
  if [ -f $HOME/cli-utils/bash-insulter/src/bash.command-not-found ]; then
     . $HOME/cli-utils/bash-insulter/src/bash.command-not-found
  fi
elif [ "$platform" == 'darwin' ]; then
  if [ -f $HOME/cli-utils/bash.command-not-found-osx ]; then
     . $HOME/cli-utils/bash.command-not-found-osx
  fi
fi

# Add cli-utils to PATH
export PATH=$HOME/cli-utils:$PATH

export PATH=$HOME/opt/usr/bin:$PATH

export EDITOR="nvim"
export VISUAL="nvim"

export IGNOREEOF=10   # Shell only exists after the 10th consecutive Ctrl-d

export PIP_REQUIRE_VIRTUALENV=false

if [ -f ~/.cpanrc ]; then
  . ~/.cpanrc
fi

