#!/bin/sh

rm -rf ~/.ks-scripts
git clone https://github.com/LinuxSuRen/ks-scripts/ -o ~/.ks-scripts
echo "source ~/.ks-scripts/ks-bash.sh" >> ~/.bashrc
