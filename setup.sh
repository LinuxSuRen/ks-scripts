#!/bin/sh

rm -rf ~/.ks-scripts
git clone https://github.com/LinuxSuRen/ks-scripts/ ~/.ks-scripts
echo "source ~/.ks-scripts/ks-bash.sh" >> ~/.bashrc
source ~/.bashrc
