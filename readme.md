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

registry_external_url 'https://registry.example.com'
gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_host'] = "registry.example.com"

registry_nginx['enable'] = true

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

# config Gitlab runner by docker
1. docker run gitlab runner
```
docker run -d --name gitlab-runner --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ./gitlab-runner-config:/etc/gitlab-runner \
  gitlab/gitlab-runner:latest

```

shell docker  confing
```
docker exec -it gitlab-runner bash
```

config gitlab runner
```
gitlab-runner register  --url http://gitlab.example.com  --token xxxx
```

config gitlab runner file comfig.yaml
```
[[runners]]
  url = "https://gitlab.example.com"
  clone_url = "https://gitlab.example.com"

  [runners.docker]
    volumes = ["/var/run/docker.sock:/var/run/docker.sock", "/cache"]
```

config registry access
```
Disable Let's Encrypt
letsencrypt['enable'] = false

Disable automatic redirection to HTTPS
nginx['redirect_http_to_https'] = false

registry_nginx['redirect_http_to_https'] = false

Ensure SSL is disabled for the registry
registry_nginx['ssl_certificate'] = nil

registry_nginx['ssl_certificate_key'] = nil

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
      -p 80:5080 \
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



# install Keycloak

How to Deploy Keycloak and Config SSO
1. Craete VM by terraform
2. ssh to server

3. install docker
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
#apt-cache policy docker-ce
sudo apt-get install -y docker-ce
```
4. install docker-compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```
5. config permisstion docker system
```
sudo usermod -aG docker ${USER}
sudo chmod 777 /var/run/docker.sock
```
6. folder keycloak to server by scp
```
scp -r keycloak ubuntu@xx.xxx.xxx.xx:/home/ubuntu
```
7. config domain and docker-compose run
```
docker-compose up -d
```

## install ingress
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

```
helm install nginx-ingress ingress-nginx/ingress-nginx \
  --namespace kube-system \
  --set controller.service.type=LoadBalancer \
  --set controller.ingressClass=nginx \
  --set controller.metrics.enabled=true \
  --set controller.metrics.serviceMonitor.enabled=true \
  --set controller.metrics.serviceMonitor.additionalLabels.release="prometheus-operator" \
  --set controller.service.annotations."cloud\.google\.com/load-balancer-type"="External"
```


##
#  Introduction to Docker, Docker-compose and mircoservice

![image description](/image/4.png)

## สร้าง Application สำหรับ Frontend
ทำการลง nodejs version 20 ขึ้นไป
## Anguler For Front-End
1. Install Lib Anguler
```
npm install -g @angular/cli
```
2. Create Project
```
ng new website
```
3. run Project
```
ng serve
```

## NextJs For Front-End
1. Create Project
```
npx create-next-app@latest
```
```
What is your project named?...user-console
Would you like to use TypeScript? No / Yes
Would you like to use ESLint? No / Yes
Would you like to use Tailwind CSS? No / Yes
Would you like to use `src/` directory? No / Yes
Would you like to use App Router? (recommended) No / Yes
Would you like to customize the default import alias? No / Yes
```
```
cd user-console
yarn dev
```

## สร้าง Application สำหรับ Backend
ทำการลง nodejs version 20 ขึ้นไป
## Python Flask API
1. install python version 3.9.6
```
https://www.python.org/downloads/release/python-396/
```
2. create project and install lib
```
mkdir dashboard-service
cd dashboard-service
touch app.py
pip install -r  requirements.txt
```
3. run application
```
python app.py
```
## Golang Echo API
1. install golang version 
```
https://go.dev/doc/install
```
2. create project and install lib
```
mkdir  payment-service
cd payment-service
touch main.go
go mod init payment-service
go mod tidy
```
3. run application
```
go mod tidy (ทำทุกครั้งเมื่อมี lib ใหม่ๆ)
go run main.go
```

## NodeJs express API
1. install NodeJs version 
```
https://nodejs.org/en/download/package-manager
```
2. create project and install lib
```
mkdir report-service
cd report-service
npm init -y
npm install express
touch server.js
```
3. run application
```
node server.js
```


## สร้าง Dockerfile สำหรับ Build และ Test Docker ด้วย command

คำสั่ง docker ที่ใช้กันบ่อยๆ
```
คำสั่งใช้สำหรับ build docker image   
  - docker build -t (*project) .
  - docker build --platform=linux/arm64 -t tag-name . (สำหรับเครื่อง mac m1 ขึ้นไป)
  
คำสั่งใช้สำหรับ run docker container
  - docker run -p public-port:private-port -d --name (*project) -e "NODE_ENV=production"  --env-file=".env" (docker images)

คำสั่งใช้สำหรับ ดู logs ใน container
  - docker logs -f (*project)

คำสั่งใช้สำหรับ shell เข้าใน container (ด้านหลังจะขึ้นอยู่คำสั่งใน image)
  - docker exec -it (*project) bash

คำสั่งใช้สำหรับการ start การทำงานของ container
  - docker rm -f (*id) 
  - docker stop (*id)

คำสั่งใช้สำหรับการ ลบ images ของ container
  - docker rmi -f (*id)

คำสั่งใช้สำหรับการ login docker
  - docker login -u ..... -p ..... url-registry

คำสั่งใช้สำหรับการ push image ขึ้น registry
  - docker push (tags)

คำสั่งใช้สำหรับการ build และ push image ขึ้น registry ไปพร้อมเมื่อ build เสร็จ
  - docker build --platform=linux/arm64 -t tag-name --push . (สำหรับเครื่อง mac m1 ขึ้นไป)
  - docker build -t tag-name --push . (สำหรับเครื่อง linux)

```

```
stages:
  - develop-build

develop-build:
  stage: develop-build
  image: docker:latest
  tags: [gitlab-docker]
  services:
    - docker:dind
  variables:
    DOCKER_TLS_CERTDIR: ""
    GCP_REPOSITORY_REGION: asia-southeast1
    GCR_IMAGE_NAME: "asia-southeast1-docker.pkg.dev/$GOOGLE_PROJECT_ID/application-registry/$CI_PROJECT_NAME"
  before_script:
    - cat ${GOOGLE_AUTH_JSON} | docker login -u _json_key --password-stdin
      https://${GCP_REPOSITORY_REGION}-docker.pkg.dev
  script:
    - docker build --pull -t $GCR_IMAGE_NAME:$CI_COMMIT_REF_NAME .
    - docker push $GCR_IMAGE_NAME:$CI_COMMIT_REF_NAME
  only:
    - develop

```

## การใช้ Helm สำหรับการ Deploy Application

ทดสอบสร้าง template สำหรับ helm
```
helm template dashboard-service -f values/default.yaml -f values/dev.yaml .
helm template payment-service -f values/default.yaml -f values/dev.yaml .
helm template report-service -f values/default.yaml -f values/dev.yaml .
helm template app-console -f values/default.yaml -f values/dev.yaml .
helm template user-console -f values/default.yaml -f values/dev.yaml .
```

ติดตั้ง application ด้วย helm
```
helm install dashboard-service -f values/dev.yaml  .
helm install payment-service -f values/dev.yaml  .
helm install report-service -f values/dev.yaml .
helm install app-console  -f values/dev.yaml  .
helm install user-console -f values/dev.yaml  .
```

ลบการติดตั้ง application ด้วย helm
```
helm uninstall dashboard-service 
helm uninstall payment-service
helm uninstall report-service
helm uninstall app-console
helm uninstall user-console
```
