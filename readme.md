# Install Gitlab

## install on os 
```
sudo apt update
sudo apt install ca-certificates curl openssh-server postfix tzdata perl
```

```
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

apt-get install gitlab-ee
```
```
sudo nano /etc/gitlab/gitlab.rb

external_url = "http://gitlab.domain.com"

sudo gitlab-ctl reconfigure
```

## install on docker
```
sudo mkdir -p /srv/gitlab
export GITLAB_HOME=/srv/gitlab
docker-compose up -d
```

password on gitlab
```
sudo docker exec -it gitlab grep 'Password:' 
/etc/gitlab/initial_root_password
```

## install acgoCD
```
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"| base64 -d;echo

kubectl port-forward svc/argocd-server -n argocd 8080:443   

kubectl create namespace application (for deploy application on namespace)
```

login
```
user : admin
password : ให้ใช้คำสั่งนี้ในการดึง kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"| base64 -d;echo
```

## install prometheus and grafana
```
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus-operator prometheus-community/kube-prometheus-stack -n monitoring
```
base64 to string
```
echo VEEtN243eU...... | base64 --decode
```

username password สำหรับ grafana
```
user : admin
pass : prom-operator
```

อ้างอิง https://prometheus-community.github.io/helm-charts/

## install grafana loki for logging view
```
helm repo add grafana https://grafana.github.io/helm-charts
helm install loki grafana/loki-stack -n monitoring
```
อ้างอิง https://grafana.com/docs/loki/latest/setup/install/helm/install-monolithic/

## Host สำหรับใช้เชื่อมต่อ
```
http://loki.monitoring.svc.cluster.local:3100
```

## install Openobserve for Observability on vm 
```
docker run -d \
      --name openobserve \
      -v $PWD/data:/data \
      -p 5080:5080 \
      -e ZO_ROOT_USER_EMAIL="root@example.com" \
      -e ZO_ROOT_USER_PASSWORD="Complexpass#123" \
      public.ecr.aws/zinclabs/openobserve:latest
```


## install Vault On Kubernetes
```
helm upgrade --install --wait vault-operator oci://ghcr.io/bank-vaults/helm-charts/vault-operator
kubectl kustomize https://github.com/bank-vaults/vault-operator/deploy/rbac | kubectl apply -f -
kubectl apply -f https://raw.githubusercontent.com/bank-vaults/vault-operator/v1.21.0/deploy/examples/cr-raft.yaml
kubectl get pods
```

```
kubectl port-forward vault-0 8200 &

export VAULT_ADDR=https://127.0.0.1:8200

kubectl get secret vault-tls -o jsonpath="{.data.ca\.crt}" | base64 --decode > $PWD/vault-ca.crt

export VAULT_CACERT=$PWD/vault-ca.crt

vault status

export VAULT_TOKEN=$(kubectl get secrets vault-unseal-keys -o jsonpath={.data.vault-root} | base64 --decode)

```

## Deploy Webhook Vault
```
kubectl create namespace vault-infra
kubectl label namespace vault-infra name=vault-infra

helm upgrade --install --wait vault-secrets-webhook oci://ghcr.io/bank-vaults/helm-charts/vault-secrets-webhook --namespace vault-infra

kubectl get pods --namespace vault-infra

```