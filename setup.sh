#!/bin/sh

function appendzsh(){
    local ksscript
    ksscript=$(cat ~/.zshrc | grep ks-script)
    if [[ "$ksscript" == "" ]]; then
        echo "source ~/.ks-scripts/ks-bash.sh" >> ~/.zshrc
    fi
}

function appendbash(){
    local ksscript
    ksscript=$(cat ~/.bashrc | grep ks-script)
    if [[ "$ksscript" == "" ]]; then
        echo "source ~/.ks-scripts/ks-bash.sh" >> ~/.bashrc
    fi
}

if [ ! -a "~/.ks-scripts" ]; then
    cd ~/.ks-scripts && git pull
else
    git clone https://github.com/LinuxSuRen/ks-scripts/ ~/.ks-scripts
fi

if [[ "$SHELL" == "/bin/zsh" ]]; then
    appendzsh
elif [[ "$SHELL" == "/bin/bash" ]]; then
    appendbash
fi
