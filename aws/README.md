# AWS Elastic Kubernetes Setup
## Project  files
1. `aws-auth-cm.yaml` Kubernetes configMap file
2. `AWS-eks-nodes.yaml` CloudFormation script that create kubernetes cluster nodes
3. `aws-eks-nodes-param.json` Parameters used in above CloudFormation script
4. `aws-eks-vpc-and-cluster.yml` CloudFormation script that create a VPC, Cluster for your EKS infrastructure
5. `aws-eks-vpc-and-cluster-params.json` Parameteres used in above cloudformation script
6. `create.sh` Shell script that create CloudFormation stack
7. `update.sh` Shell script aht update CloudFormation stack
## Create Kubernetes VPC and EKS cluster
Below shell script create a VPC and Elastic Kubernetes Services (EKS) Cluster 
 
 `./create.sh aws-eks-vpc aws-eks-vpc-and-cluster.yml aws-eks-vpc-and-cluster-params.json`
 
## Create EKS nodes
Below shell script create worker nodes associated to above Cluster
`./create.sh aws-eks-nodes aws-eks-nodes.yaml aws-eks-nodes-param.json`

## Update Kubernetes config file
`aws eks update-kubeconfig --name eks-cluster`

## Apply The arn role
Replace `arn:aws:iam::828370275182:role/aws-eks-nodes-NodeInstanceRole-143AZV3JNWBLF` in `aws-auth-cm.yaml`

Apply changes by running `Kubectl apply -f aws-auth-cm.yaml`.
Test your configurations by running `Kubectl get no -o wide` to show up your nodes
