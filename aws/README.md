# AWS Elastic Kubernetes Setup
## Prerequisites
To run below setup, you first need and AWS account and AWS CLI installed
* [Create new AWS account](https://aws.amazon.com/fr/resources/create-account/) if you dont have one
* [Install the latest AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) if you dont have to be able to run incoming scripts
## Project  files
1. `aws-auth-cm.yaml` Kubernetes configMap file
2. `AWS-eks-nodes.yaml` Cloudformation script that create kubernetes cluster nodes
3. `aws-eks-nodes-param.json` Parameteres used in above cloudformation script
4. `aws-eks-vpc-and-cluster.yml` Cloudformation script that create a VPC, Cluster for your EKS infrastructure
5. `aws-eks-vpc-and-cluster-params.json` Parameteres used in above cloudformation script
6. `create.sh` Shell script that create cloudformation stack
7. `update.sh` Shell script aht update cloudformation stack
## Create Kubernetes VPC and EKS cluster
Run below shell script wich execute the cloudformation script that create a VPC and Networks
for your kubernetes cluster 
 
 `./create.sh aws-eks-vpc aws-eks-vpc-and-cluster.yml aws-eks-vpc-and-cluster-params.json`
## Create EKS nodes
Run below shell script wich run cloudformation script that create worker nodes associated to above
VPC
`./create.sh aws-eks-nodes aws-eks-nodes.yaml aws-eks-nodes-param.json`
## Install Kubectl
To be able to work with your cluster you will need to install Kubectl
[Following this guide](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/) .
After installing Kubectl, run `Kubectl version` to show your installed version
## Apply The arn role
Replace `arn:aws:iam::828370275182:role/aws-eks-nodes-NodeInstanceRole-143AZV3JNWBLF` in `aws-auth-cm.yaml` with yours
to apply be able to work with your nodes.
To apply to your cluster, run `Kubectl apply -f aws-auth-cm.yaml`.
To test your infrastructure, run `Kubectl get no -o wide` to show up your nodes
