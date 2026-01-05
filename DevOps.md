Easyshop - Modern E-commerce Platform

Easyshop is a modern, full-stack e-commerce platform built with Next.js 14, Typescript, and Mongodb, It featurees a beautiful UI Tailwind CSS, secure authentication, real-time cart updatees, and a seamless shopping exprience. 

Reatures

. Modern and responsive UI with dark mode support
. Secure JWT-based authentication
. Real-time cart management with Redux
. Mobile-first design approch
. Advanced product search and filtering
. Secure checkout process
. Multiple product categories
. User profiles amnd order history
. Dark/Light theme support

Architecture

Easyshop follows a three-tier architecture pattern:

1. Presentation Tier (Frontend)

. Next.js React Components
. Redux for Sstate Management 
. Tailwind CSS for Styling
. Client side Rotuing
. SResponsive UI Components

2. Application TIer (Backend)

. Next.js Api Routs
. Business Logic
Authentication & Authorization
 Request Validation
 . Error Handling\
 . Data Processing

 3. Data TIer (Database)

 . MongoDB Database
 . Mongoose ODM 
 . Data Models
 . CRUS Operations
 . Data Validation

 PrekREquidites

 Important

 Before you begin setting up this project,  make sure the following tools are installed and configured properlyon your system.:

 Setuo & Initialization

 1. Install terraform
 . Install Terraform 

 Linux & macOS

 curl -fsSL HTTPS://APT.RELEASES.hashicorp.com/gpg



 Verify INstallation

 ```
 terraform -v
 ```

 Initialize Terraform
terraform init

2. Install AWS CLI

AWS CLI (Command Line Interface) allows you to interact with AWS services directly from the command line.

curl "httpsSSSSSSSSSSSSSSSSSSSSS//awscli


Install AWS CLI in WINDOWS 'POWERSHELL"

msiexec.exe /i https://aescli.

```
aws configure
```

This will prompt you to enter:

. AWS Access Key ID:
. AWS Secret Access Key: 
. Default region name:
. Default output formate

Note

Make sure the IAM user you're using has the necessary permissions. you'll need an AWS IAM Role with programmatic access enabled, along with the access key and SECRET Key.

Getting Ssssssarted

Follow the steps below to get your infrustructure up and running using Terraform:

1. Clone the Repository: FIrst, clone this repo to your local machine:
```
git clone https:
```

2. Gsenerate ssh key Pair: Create a new ssh key toaccess your EC2 instance:
```
ssh-keygen -f terra-key
```
This will prompt you to create a new key file named terra-key.

3. Private Key permission: Change your private key permission:
```
chmod 400 terra-key
```

4. Initialize Terraform: Initialize the Terraform working directory to download required providers:
```
terraform init
```

5. Review the Execution Plan: Before apply the changes and  the insfrastructure:

```
terraform plan
```

6. Apply the ConfigurationkKKKKKK: Now, apply the changes and create the infrustructure:

```
terraform apply
```
Confirm with ```yes``` when prompted.

7. Access Your EC2 Instance;
After deployment, grab the public IP of your EC2 instance from the output or AWS Console, then connect using SSH:
```
ssh -i terra-key ubuntu
```
k
8. Update your kubeconfig: wherever you want toaccess your eks wheather it is you local machine or bastion server this command will helpl you to intrect with your eks.

Caution

You need to configure aws cli first to execute this command:

```
aws configure
```

```
aws eks --region eu-west-1 update-kubeconfig --name tws-eks-cluster
```

9. Check your cluster:
```
kubectl get nodes
```

Jenkins Setup Steps

TIps

Check if jenkind service is running:

```
sudo systemctl status jenkind
```

Steps to access jenkins & Install Plugins

1. Open jenkins in Browser:
Use your public IP with port 8080: httl://<public IP > :8080

2. inITIAL aDMIN pASSWORD:
sTART the service and get the jenkins initial admin password:

```
sudo cat
```

3. Start jenkins (IF NOT RUNNING):
Get the jenkins initial admin password:

```
sudo systemctl enable jenkins
sudo systemctl restart jenkins
```

4. Installl Essential Plugins:
. Navigate to: Manage jenkins  Plugins Available plugins
. Search and install the following:

Dock Pipeline
Pipeline View

5. Setup Docker & Github Credentials in jenkins (Global Credentials)

. Go to: jenkins  Manage jenkins  Credentials section

.use:

   . Kind: Username with password
   . ID: github-credentials

DockerHub Credentials: Go to the same Global Credentials section
use:

    KInd: Username with password
    ID: docker-hub-credentials [Notes:] Use these IDs in your jenkins pipeline for secure access to github and DockerHUb

6. Jenkins Shared Library Setup:
```
configure
```

Go to : Jenkins  Manage jenkins   Configure System Scroll to Global Pipeline Libraries section

Add a Neeeeeeeeew Shared Library:

Name: Shared

Default Version: main
Project Repository URL: ```http://     ```

[Notes:] Make sure the repo contains a proper dirctory structure eq: vars/ 

 7. Setup Pipeline

Create Neeeeew Pipeline Job
   Name: Easyshop
   Type: Pipeline
   Press ```okey```

   in Genral

   Description: Easyshop
   Check the box: ``` Github projrct```
   Github Repo URL:    ``` HTTPS://       ````

In Trigger

    Definition: ``` Pipeline script from scm```
    SCM: ```GIT```
    Repository URL: ```https://    ```
    Credentials: ```github-cridentials```
    Branch: master
    Script Path: ```jenkinsfile```


Fork Required Repos

    Fork App Repo:
        Open the ```jenkinsfile
        Change the DockHub username to yours
 
Sssssssssetup Wewbwhook
In GitHub:

     GO to ```setting```   ```weblhook

     Add a new webhook pointing to your jenkins URL
     Select: github hook trigger for GITScm polling in jenkins job 

     Trigger the pipeline
     Click build Now in jenkins

     8.  CD -Contuous DEPLOYMENT Setup 

     Prerequisites:
     Before configuring CD, make sure the following tools are installed:
     Installations Required:
     kubectl
     AWS CLI

     SSH into bastion server

     connect to your bastion ec2 instance via ssshl.

     Note: This is not the node where jenkins is running. This is hte intermediate ec2 (Bastion Host) used for accessing private resource like your EKS cluster.

8. Configure aws cli on bastion server run the aws configure command:
aws configure
Add your access key and secret key when prompted.

9.  Update kubeconfig for eks

Run the following important command:

aws eks ypdate - kubeconfige --region eu


this command maps your eks cluster with your bastion server.
It helps tocommunicate with eks components.

10. Install aws application load balancer refering the below docs link

https:// docs.aws.amazon

11. Argo CD SETUP
Create a namespace for Argocd
 kubectl create manespace argocd

 1. Install argo cd using helm


 jelm repo add argo https:
 helm install my-argo-cd argo/argo-cd --version

 2. get the value file and save it

 helm show  vallues argo/argo

3. edit the value file, change the below setting. 


global:
    domain: argo.example.com

    configs:
        params:
            server.insecure: true
server





4. save and upgrade the helm chart.

helm upgrade my-argo-cd argo/argo

5. add the record in route53 "argocd.devsdock.site" with load balancer dns.

6. access it in browser.

7. retrive the secret for argocd

kubectl -n argocd get secret-initiall-admin-secret -o 


8. login to argocd "admin and retrieved password
9. Changing the password by going to "user info" tab in the UI/

DEPLOY YOUR APPLICATION IN ARGOCD  GUI
On the Argo CD homepage, click on the "New App" button.

Fill in the following details:

    . Aplication Name: Select  default from the dropdown .
    sync Policy: Choose Automatic.

In the source section:
    . Repo URL: Add the Git repoditory URL that contains your kubernetes manifests.
    Path:  kubernetes (or the actule inside the reor where your manifests reside)

Click on create.

NOTE: before deploying change your ingress setting and image tag in the yaml inside kubermnetes derectory.

iNGRESS aNNOTATIONS:

ANNOTATIONS:
    alb.ingress.kubernetes.io/group.name






add record to route 53 "easyshop.devsdock.site"
Access your site now.

INstall Metric Server

 . metric server install thru helm chart

 httpss://


 verify metric server.
 kubectl get pods -w
 kubectl top pods


 Monitoring using kube-promethues-0stack


 create a namesspace "monitoring"

 kubectl create ns monitoring

 https://artifacthubl.io

 verify deployment:
 kubectl get pods -n monitoring

get the helm values and save it in a file

helm show value prometheus-community

edit the file and add the following in the params for prometheus, grafana and alert manager.

Grafane:

ingresssClassname>:  alb





Prometheus:

ingressclassNamre:  alb




Alertmanager:
ingressClassName:  alb
annotation:



Alerting toslack 
create a new slack

Create a new workspace in slack, create a new channel e.g. #$alerts

go to https://api               to create the webhook.


1. create an app "alertmanager"
2. go to incoming webhook
3. create a webhook and copy it.

modify the helm values.

config: 
    global:
        resolve_timeout: 5m







NOTE: you can refer this DOCS for the slack configuration.


upgrade the chart 

helm upgrade my-kube-prometheus-stack prometheus-community/kube-prometheus-stack -f 


get grafana secret "user=admin"

you would get the notification in the slack resctive channel,

LOGGING

we will use elasticsearch for logsstore, filebeat for log shipping and kibana for visualization.

NOTE: the     EBS driver installed is for elasticsearch to dynamically provision an


Install Elastic Search:

helm reo add elastic
helm indtall my-elasticsearch elastic/elasticsearch

Create a strongclass so that elastic search can synamically provisoion volume in aws.

storageclass.yml

apiVersion: storage.k8s.io/kv1
kilnlllllllllldL: storageclass




apply the yaml file.
d
get the value for elastic search helm chart.
helm show value elastic/alasltic

update the values

replicas:1
minimimMasterSNOdesSSSSSSSSSS:



upgrade the chartk
helm upgrade my-elasticsearch

if upgrade does not happen the uninstall and install lit agaillllllllllllllllllln.



make sure the pod is running.

kubectl get po -n logging

NAME                        READY           STATUS          RESTART                 AGE
elastic-oprator-0
elasticsearch-master-0


FILE BEAT"
Install filebeat for log shipping.
helm repo add elastic https://helm
helm install my-filebesat elastic

get show values 


FileBeat runs as a daemonset. check if its up.

kubectl get po -n logging
NAME                                        READY       STATUS              RESTARTS            AGE
    ELASTIC-OPERATOR-0




Install KIBANAs:

INSTALL KIBANA THROUGH HELM.

HELM REPO ADD
helm install my-kibana elastic.kibana --version


Verify if it runs.

k get po -n logging
NAME                READY           STATUS      RESTART         AGE




Get values
helm show values elastic/kibana > kibana.lyaml


modify the calue for ingress settings
ingress:
    enabledL  true




    Save the file and exit. upgrade the helm chart using the values file.
    helm upgrade my-kibana

add all the records to route 53 and give the value as load balancer DNS name. and try to access one by one.

retrive the secret of elastic search as kibana'ls password, username is elastic

kubectl get secret --namespace=logging elasticsearch-master-credentials -o



Filebeat configuration to ship the easyshop" app logs elaticsearch

configure filebeat to ship the application logs view in kibana

filebeatconfigs:
    FILEBEAT.YML:  |
    filebeat.inputs:




upgrade filebeat jelm chart and check in kibana's ui if the app logs are streaming.


CONGRATULATIONS!
