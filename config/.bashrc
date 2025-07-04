# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
BASHRC_START_TIME=$(date +%s.%N) # karim Début du timer
export BASH_ALIASES="/mnt/BigDatas/PersonalCloud/Configurations/bash_addons/.bash_aliases"
export BASH_FUNCTIONS="/mnt/BigDatas/PersonalCloud/Configurations/bash_addons/.bash_functions"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

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

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#karim alias
BASHRC_START_SECTION=$(date +%s.%N) #Début mesure section alias

# Chargement des alias
if [ -f "$BASH_ALIASES" ]; then
    . "$BASH_ALIASES"
fi
BASHRC_END_SECTION=$(date +%s.%N) #Fin mesure section alias

KARIM_ALIAS=$(echo "$BASHRC_END_SECTION - $BASHRC_START_SECTION" | bc)

#karim alias end 

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

#karim fonctions
BASHRC_START_SECTION=$(date +%s.%N) #Début mesure section fonctions

# Chargement des fonctions
if [ -f "$BASH_FUNCTIONS" ]; then
    . "$BASH_FUNCTIONS"
fi

BASHRC_END_SECTION=$(date +%s.%N) #Fin mesure section fonctions

KARIM_FUNCTIONS=$(echo "$BASHRC_END_SECTION - $BASHRC_START_SECTION" | bc)
#karim end fonctions 


# Karim oh-my-posh
BASHRC_START_SECTION=$(date +%s.%N) #Début mesure section oh-my-posh
#eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/M365Princess.omp.json)"
eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/dracula.omp.json)"

BASHRC_END_SECTION=$(date +%s.%N) #Fin mesure section fonctions
KARIM_OHMYPOSH=$(echo "$BASHRC_END_SECTION - $BASHRC_START_SECTION" | bc)
# Karim end oh-my-posh

#echo "
# .----------------.   .------------------.   .----------------.  .------------------.  .-------------------. 
#| .--------------. | | .----------------. | | .--------------. | | .--------------. | | .----------------. |
#| |  ___  ____   | | | |       __       | | | |  _______     | | | |     _____    | | | |  ____    ____  | |
#| | |_  ||_  _|  | | | |      /  \      | | | | |_   __  \   | | | |    |_   _|   | | | | |_   \  /   _| | |
#| |   | |_/ /    | | | |     / /\ \     | | | |   | |__)  |  | | | |      | |     | | | |   |   \/   |   | |
#| |   |  __'.    | | | |    / ____ \    | | | |   |  __  /   | | | |      | |     | | | |   | |\  /| |   | |
#| |  _| |  \ \_  | | | |  _/ /    \ \_  | | | |  _| |  \ \_  | | | |     _| |_    | | | |  _| |_\/_| |_  | |
#| | |____||____| | | | | |____|  |____| | | | | |____| |___| | | | |    |_____|   | | | | |_____||_____| | |
#| |              | | | |                | | | |              | | | |              | | | |                | |
#| '--------------' | | '----------------' | | '--------------' | | '--------------' | | '----------------' |
# '-----------------' '--------------------' '------------------' '------------------' '--------------------' 
# "

# Calcul et affichage du temps d'exécution
BASHRC_END_TIME=$(date +%s.%N)
BASHRC_DURATION=$(echo "$BASHRC_END_TIME - $BASHRC_START_TIME" | bc) # Calcul et affichage du temps d'exécution
echo "               Section Alias : $(echo "$KARIM_ALIAS" ) secondes"
echo "           Section Fonctions : $(echo "$KARIM_FUNCTIONS" ) secondes"
echo "          Section oh-my-posh : $(echo "$KARIM_OHMYPOSH" ) secondes"
echo "Temps d'exécution du .bashrc : ${BASHRC_DURATION} secondes"
source ~/.local/share/blesh/ble.sh
neofetch
#alias
