#
# ~/.bashrc
#
export GTK_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#java
export JAVA_HOME=/usr/local/env/jdk
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
#bin path
export PATH=$HOME/bin:$PATH

alias ls='ls --color=auto'
alias ll='ls -l --color=auto'

#source alias file
if [ -f ~/.aliasrc ]; then
	. ~/.aliasrc
fi



PS1='[\u@\h \W]\$ '

source ~/.git-completion.bash
