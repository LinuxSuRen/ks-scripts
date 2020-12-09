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
function ks-installer-deploy-edit(){
	kubectl -n kubesphere-system edit deploy ks-installer
}
function ks-installer-update(){
	kubectl -n kubesphere-system patch deploy ks-installer --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "'$1'"}]'
}

function ks-pod(){
	kubectl -n kubesphere-system get pod -w
}
function ks-devops-pod(){
	kubectl -n kubesphere-devops-system get pod -w
}

# ks apiserver
function ks-apiserver-update(){
	kubectl -n kubesphere-system patch deploy ks-apiserver --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "'$1'"}]'
}
function ks-apiserver-log(){
	kubectl -n kubesphere-system logs deploy/ks-apiserver --tail 50 -f
}
function ks-apiserver-edit(){
	kubectl -n kubesphere-system edit deploy/ks-apiserver
}
function ks-apiserver-reset(){
	ks-apiserver-update "kubesphere/ks-apiserver:v3.0.0"
}
function ks-apiserver-reset-latest(){
	ks-apiserver-update "kubespheredev/ks-apiserver:latest"
}
function ks-apiserver-del-pod(){
	local pod
	pod=$(kubectl -n kubesphere-system get pod | grep ks-apiserver | awk '{print $1}')
	if [[ "$pod" == "" ]]; then
		echo 'ks-apiserver is not ready'
	else
		kubectl -n kubesphere-system delete pod $pod
	fi
}

# controller
function ks-controller-update(){
	kubectl -n kubesphere-system patch deploy ks-controller-manager --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "'$1'"}]'
}
function ks-controller-log(){
	kubectl -n kubesphere-system logs deploy/ks-controller-manager --tail 50 -f
}
function ks-controller-edit(){
	kubectl -n kubesphere-system edit deploy/ks-controller-manager
}
function ks-controller-reset(){
	ks-controller-update "kubesphere/ks-controller-manager:v3.0.0"
}
function ks-controller-reset-latest(){
	ks-controller-update "kubespheredev/ks-controller-manager:latest"
}
function ks-controller-del-pod(){
	local pod
	pod=$(kubectl -n kubesphere-system get pod | grep ks-controller-manager | awk '{print $1}')
	if [[ "$pod" == "" ]]; then
		echo 'ks-controller is not ready'
	else
		kubectl -n kubesphere-system delete pod $pod
	fi
}

# console
function ks-console-edit(){
	kubectl -n kubesphere-system edit deploy/ks-console
}
function ks-console-update(){
	kubectl -n kubesphere-system patch deploy ks-console --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "'$1'"}]'
}
function ks-console-reset(){
	ks-console-update "kubesphere/ks-console:v3.0.0"
}
function ks-console-reset-latest(){
	ks-console-update "kubespheredev/ks-console:latest"
}
function ks-console-del-pod(){
	local pod
	pod=$(kubectl -n kubesphere-system get pod | grep ks-console | awk '{print $1}')
	if [[ "$pod" == "" ]]; then
		echo 'ks-console is not ready'
	else
		kubectl -n kubesphere-system delete pod $pod
	fi
}

# jenkins
function ks-j-exec(){
	local pod
	pod=$(kubectl -n kubesphere-devops-system get pod | grep ks-jenkins | awk '{print $1}')
	if [[ "$pod" == "" ]]; then
		echo 'Jenkins is not ready'
	else
		kubectl -n kubesphere-devops-system exec -it $pod bash 
	fi
}
function ks-j-edit(){
	kubectl -n kubesphere-devops-system edit deploy/ks-jenkins
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
function ks-user-reset(){
	kubectl patch users $1 -p '{"spec":{"password":"'$2'"}}' --type='merge'
	kubectl annotate users $1 *- iam.kubesphere.io/password-encrypted- kubesphere.io/creator-
}

function kk-install(){
	curl -L https://github.com/LinuxSuRen/kubekey/releases/download/v1.0.3/kk-linux-amd64.tar.gz | tar xzv
	sudo mv kk /usr/local/bin/kk
}

function ks-script-fetch(){
	if [ ! -a "~/.ks-scripts" ]; then
    	cd ~/.ks-scripts && git pull
	else
		git clone https://github.com/LinuxSuRen/ks-scripts/ ~/.ks-scripts
	fi
}
function ks-build(){
	# we need to build a particular binary instead of default one in some cases
	if [[ "${KS_BUILD_GOOS}" != "" ]]; then
		GOOS=${KS_BUILD_GOOS} make docker-build-no-test
  else
	  make docker-build-no-test
	fi
}
alias ks-script-update='ks-script-fetch && if [[ "$SHELL" == "/bin/zsh" ]]; then source ~/.zshrc; elif [[ "$SHELL" == "/bin/bash" ]]; then source ~/.bashrc; fi'
