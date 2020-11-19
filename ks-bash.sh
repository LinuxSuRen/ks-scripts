# Please import this file into your bashrc file
# source ks-bash.sh

function ks-devops-disable(){
	kubectl -n kubesphere-system patch cc ks-installer -p '{"spec":{"devops":{"enable":false}}}' --type="merge"
}
function ks-devops-enable(){
	kubectl -n kubesphere-system patch cc ks-installer -p '{"spec":{"devops":{"enable":true}}}' --type="merge"
}

function ks-apiserver-update(){
	kubectl -n kubesphere-system patch deploy ks-apiserver --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "$1"}]'
}
function ks-apiserver-log(){
	kubectl -n kubesphere-system logs deploy/ks-apiserver --tail 50 -f
}
function ks-controller-update(){
	kubectl -n kubesphere-system patch deploy ks-controller-manager --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "$1"}]'
}
function ks-controller-log(){
	kubectl -n kubesphere-system logs deploy/ks-controller-manager --tail 50 -f
}
