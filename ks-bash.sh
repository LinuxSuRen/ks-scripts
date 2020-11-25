# Please import this file into your bashrc file
# source ks-bash.sh

function ks-devops-disable(){
	kubectl -n kubesphere-system patch cc ks-installer -p '{"spec":{"devops":{"enabled":false}}}' --type="merge"
}
function ks-devops-enable(){
	kubectl -n kubesphere-system patch cc ks-installer -p '{"spec":{"devops":{"enabled":true}}}' --type="merge"
}
function ks-installer-log(){
	kubectl -n kubesphere-system logs deploy/ks-installer --tail 50 -f
}
function ks-installer-edit(){
	kubectl -n kubesphere-system edit cc ks-installer
}

function ks-apiserver-update(){
	kubectl -n kubesphere-system patch deploy ks-apiserver --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "'$1'"}]'
}
function ks-apiserver-log(){
	kubectl -n kubesphere-system logs deploy/ks-apiserver --tail 50 -f
}
function ks-apiserver-edit(){
	kubectl -n kubesphere-system edit deploy/ks-apiserver
}
function ks-controller-update(){
	kubectl -n kubesphere-system patch deploy ks-controller-manager --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "'$1'"}]'
}
function ks-controller-log(){
	kubectl -n kubesphere-system logs deploy/ks-controller-manager --tail 50 -f
}
function ks-controller-edit(){
	kubectl -n kubesphere-system edit deploy/ks-controller-manager
}
function ks-j-exec(){
	pod=$(kubectl -n kubesphere-devops-system get pod | grep ks-jenkins | awk '{print $1}')
	if [[ "$pod" == "" ]]; then
		echo 'Jenkins is not ready'
	else
		kubectl -n kubesphere-devops-system exec -it $pod bash 
	fi
}
function ks-j-log(){
	kubectl -n kubesphere-devops-system logs deploy/ks-jenkins --tail=50 -f
}
function ks-j-on(){
	kubectl -n kubesphere-devops-system scale deploy/ks-jenkins --replicas=1
}
function ks-j-off(){
	kubectl -n kubesphere-devops-system scale deploy/ks-jenkins --replicas=0
}
