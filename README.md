# Cloud DevOps Engineer Nanodegree Capstone project
## Project description: California tours app
The goal of this project is
- to implement CI/CD pipeline using Jenkins
- User cloudformation to to deploy Kubernetes clusters
- Building Docker containers in pipelines
- Deploy an app that show California tours details. the data is store
in postgres database and the app is deployed in Kubernetes cluster
with two nodes (one master and two worker nodes)
- The database use NodePort service so that I can access outside the cluster to manage the data
- The app is accessible through a loadbalancer
- I use rolling deployment

## Project files and folder
1. `Dockerfile` the dockerfile that is used to build an image of the app to be published
in Elastic contaier Registry
2. `Jenkinsfile` The jenkinsfile that will automate the deployment
3. `aws` folder contains cloudformation script and a readme for more informations
4. `k8s-deployments` contains kubernetes deployment script and a readme for more informations

## Automation guide
1. Install jenkins
2 install blueOcean plugins, ECR plugin and maven
3. Configure the github project in your blueOcean pipeline
4. That will run all steps to get an image and push to ECR
5. Important: Make sur to replace the Jenkinsfile repo with yours and make sur to replace
put your image in front-end deployment
## Rolling out deployment guide
### Step 1
Make your first deployment in your pods with a specific image tag
### Step 2
Make some changes to the project and build a new image
### Step 3
Once the new image is published to ECR, apply it to the deployment

Kubernetes will shutdown one pod and deploy the new app and if everything goes well
others pods will be redirect to the newly created app
### Step 4
You can rollback to the previous version if needed
