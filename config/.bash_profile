# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs
alias python=python3.7
alias pip=pip3
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/var/task/lib
PATH=$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.pyenv/shims:/var/task/bin
export PATH
export LD_LIBRARY_PATH