#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias pm='sudo pacman -Syyu'
alias ping='ping www.google.com'
PS1='[\u@\h \W]\$ '

export EDITOR=nvim
export WM=evilwm
