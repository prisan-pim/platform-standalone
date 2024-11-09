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

# install acgoCD
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


# Monitoring

## Install Prometheus Node Exporter

## 1.install Node Exporter

Download Node Exporter
```
sudo wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz
```

Extract Files
```
sudo tar xzf node_exporter-1.7.0.linux-amd64.tar.gz
sudo rm -rf node_exporter-1.7.0.linux-amd64.tar.gz
```

Move Files
```
sudo mv node_exporter-1.7.0.linux-amd64 /etc/node_exporter
```

Create Service
```
sudo nano /etc/systemd/system/node_exporter.service
```

Config Service File Run On System
```
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
ExecStart=/etc/node_exporter/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
```

Run Node Exporter
```
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl restart node_exporter
```

Check System
```
sudo systemctl status node_exporter
```

## 2.install Prometheus

Download and Extract Files
```
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz

sudo tar vxf prometheus*.tar.gz
```

Create User for Prometheus
```
sudo groupadd --system prometheus
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
```

Create Folder System
```
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
```

Move File
```
cd prometheus/

sudo mv prometheus /usr/local/bin
sudo mv promtool /usr/local/bin

sudo mv console* /etc/prometheus
sudo mv prometheus.yml /etc/prometheus
```

Set Permisstion file
```
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown -R prometheus:prometheus /var/lib/prometheus
```

Config prometheus.yaml
```
sudo nano /etc/prometheus/prometheus.yml
```
```
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node'
    static_configs:
      - targets: ['localhost:9100']
```

Create Systemd Service
```
sudo nano /etc/systemd/system/prometheus.service
```


Config Service File Run On System
```
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
 --config.file /etc/prometheus/prometheus.yml \
 --storage.tsdb.path /var/lib/prometheus/ \
 --web.console.templates=/etc/prometheus/consoles \
 --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
```

Start System
```
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
```

Check Prometheus Status
```
sudo systemctl status prometheus
```

Grafana Dashbaord 

id 
```
1860
```

## Install Prometheus and Grafana on gke
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