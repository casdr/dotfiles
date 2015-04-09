if [ -f /etc/bashrc ]; then
. /etc/bashrc
fi
 
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
 
xhost +local:root > /dev/null 2>&1
 
complete -cf sudo
 
shopt -s cdspell
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s hostcomplete
shopt -s nocaseglob
 
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTIGNORE="&:ls:[bf]g:exit"
 
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
 
# append to the history file, don't overwrite it
shopt -s histappend
 
# multi-line commands are stored in the history as a single command
shopt -s cmdhist
 
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
 
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# short cd aliases
alias back='cd $OLDPWD'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# alias grep='grep --color=tty -d skip'
alias l='ls -Ca'
alias lr='ls -ltrh'
alias lra='ls -ltrha'
alias ls='ls --group-directories-first --color=auto'
alias ll='ls -alFh --group-directories-first --color=auto'
alias la='ls -A --group-directories-first --color=auto -F'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cp="cp -i"
alias rm='rm -i'
alias np='nano PKGBUILD'
alias sudoenv='sudo env PATH=$PATH'
alias xo='xdg-open &>/dev/null'
alias xsetkeyr='xset r rate 182 42'
alias tmuxkillall="tmux ls | awk '{print $1}' | sed 's/://g' | xargs -I{} tmux kill-session -t {}"
alias e='leafpad'
 
# ex - archive extractor
# usage: ex <file>
ex ()
{
if [ -f $1 ] ; then
case $1 in
*.tar.bz2) tar xjf $1 ;;
*.tar.gz) tar xzf $1 ;;
*.bz2) bunzip2 $1 ;;
*.rar) unrar x $1 ;;
*.gz) gunzip $1 ;;
*.tar) tar xf $1 ;;
*.tbz2) tar xjf $1 ;;
*.tgz) tar xzf $1 ;;
*.zip) unzip $1 ;;
*.Z) uncompress $1;;
*.7z) 7z x $1 ;;
*) echo "'$1' cannot be extracted via ex()" ;;
esac
else
echo "'$1' is not a valid file"
fi
}

# get current host related info
function ii()
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&. ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:."Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:."Not connected"}
    echo
}

 
# prompt
# PS1='[\u@\h \W]\$ '
PS1='\u@\h \W\$ '
BROWSER=/usr/bin/xdg-open
 
export PATH=$HOME/Dropbox/remote:$PATH
export PATH=$HOME/.gem/ruby/2.0.0/bin:$PATH
 
 
# less highlight
# sudo pacman -S source-highlight
# export LESSOPEN="| src-hilite-lesspipe.sh %s"
# export LESS=' -R '
alias les='LESSOPEN="| src-hilite-lesspipe.sh %s" LESS=" -R " less -N'
 
# source files
if [[ -s $HOME/pv0/bin/activate ]]; then
. $HOME/pv0/bin/activate
fi
 
if [[ -s /usr/share/git/completion/git-completion.bash ]]; then
. /usr/share/git/completion/git-completion.bash
fi
 
if [[ -s /etc/profile.d/autojump.bash ]]; then
. /etc/profile.d/autojump.bash
fi
 
if [[ -s $HOME/perl5/perlbrew/etc/bashrc ]]; then
. $HOME/perl5/perlbrew/etc/bashrc
fi 

