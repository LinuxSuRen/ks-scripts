# Please import this file into your bashrc file
# source ks-bash.sh

alias ks-devops-disable='kubectl -n kubesphere-system patch cc ks-installer -p '{"spec":{"devops":{"enable":false}}}' --type="merge"'
alias ks-devops-enable='kubectl -n kubesphere-system patch cc ks-installer -p '{"spec":{"devops":{"enable":true}}}' --type="merge"'
