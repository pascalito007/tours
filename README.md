# Cloud DevOps Engineer Nanodegree Capstone project

[Project repositry URL](https://github.com/pascalito007/tours)

## Project description: California tours app
The goal of this project is
- To implement CI/CD pipeline using Jenkins
- Use CloudFormation to to deploy Kubernetes clusters
- Building Docker containers in pipelines
- Deploy an app that shows California tours details. The app use the latest Postgres database image to store 
 tours data. The app and database are deployed using differents deployment in AWS Kubernetes Cluster
- The database use NodePort service for public access to the database and for pods communications
- The app is accessible through a Loadbalancer managed by AWS
- I use Rolling Update Deployment strategy as it is built in kubernetes

## Prerequisites
To setup the project, you first need and AWS account and AWS CLI, KubeCtl installed
* [Create new AWS account](https://aws.amazon.com/fr/resources/create-account/) if you dont have one
* [Install the latest AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) if you dont have one to be able to run incoming scripts

Test your installation by running `aws --version`
* [Following this guide](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/) to install kubectl

Test your installation by running  `Kubectl version`

## Project files and folder
1. `Dockerfile` The Dockerfile that is used to build an image of the app to be published in Elastic Container Registry (ECR)
2. `Jenkinsfile` The jenkinsfile that will automate the deployment
3. `aws` Folder contains cloudformation script and a readme for more informations
4. `k8s-deployments` Contains kubernetes deployment script and a readme for more informations

## Jenkins pipeline automation guide
1. Install jenkins
2. Install blueOcean, ECR, AWS CLI, Docker, KubeCtl, maven plugins
3. Configure the github project in your blueOcean pipeline
4. That will run all steps
5. Important: Make sur to replace the Jenkinsfile repo with yours and make sur to replace the image with yours in front-end deployment
## Rolling Update deployment strategy
### Step 1: First deployment
The front-end deployment use `tours:1.0` as shown below
```
mewejp@MBPdeMEENEMESSE tours % kubectl get deploy,po -o wide 
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS     IMAGES                                                   SELECTOR
deployment.extensions/app   3/3     3            3           22m   ctn-app        828370275182.dkr.ecr.us-west-2.amazonaws.com/tours:1.0   app=web
deployment.extensions/db    3/3     3            3           52m   ctn-tours-db   postgres:latest                                          app=db

NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE                                       NOMINATED NODE   READINESS GATES
pod/app-6c4fd6575b-gfnt7   1/1     Running   0          22m   10.0.0.99    ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/app-6c4fd6575b-pdkfj   1/1     Running   3          22m   10.0.1.205   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
pod/app-6c4fd6575b-v7drb   1/1     Running   0          22m   10.0.1.34    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-78p9n    1/1     Running   0          52m   10.0.0.161   ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/db-8645554dd6-vcm2n    1/1     Running   0          52m   10.0.1.99    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-vvslr    1/1     Running   0          52m   10.0.1.131   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
mewejp@MBPdeMEENEMESSE tours % 
                                          app=db
```
### Step 2: New front-end release
Make some changes to the project and build and deploy new release. The newly created image is tagged `tours:2.0`
### Step 3: New release deployment
Apply changes with the newly created image
As shown below, Kubernetes stop one inactive container, deploy the new font-end app with the newly
created image with new container and when up and running, all other pods will run the new
deployment
```
mewejp@MBPdeMEENEMESSE k8s-deployments % kubectl apply -f tours-app-deployment.yml 
deployment.apps/app configured
service/websvc unchanged
mewejp@MBPdeMEENEMESSE k8s-deployments % kubectl get deploy,po -o wide            
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS     IMAGES                                                   SELECTOR
deployment.extensions/app   3/3     3            3           33m   ctn-app        828370275182.dkr.ecr.us-west-2.amazonaws.com/tours:2.0   app=web
deployment.extensions/db    3/3     3            3           62m   ctn-tours-db   postgres:latest                                          app=db

NAME                       READY   STATUS              RESTARTS   AGE   IP           NODE                                       NOMINATED NODE   READINESS GATES
pod/app-6c4fd6575b-gfnt7   1/1     Terminating         0          33m   10.0.0.99    ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/app-6c4fd6575b-v7drb   1/1     Running             0          33m   10.0.1.34    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-58jnj   0/1     ContainerCreating   0          1s    <none>       ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-nq9sx   1/1     Running             0          8s    10.0.1.114   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-xkmmn   1/1     Running             0          3s    10.0.0.180   ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/db-8645554dd6-78p9n    1/1     Running             0          62m   10.0.0.161   ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/db-8645554dd6-vcm2n    1/1     Running             0          62m   10.0.1.99    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-vvslr    1/1     Running             0          62m   10.0.1.131   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
```

Pods up and running with the new release 
```
mewejp@MBPdeMEENEMESSE tours % kubectl get deploy,po -o wide
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS     IMAGES                                                   SELECTOR
deployment.extensions/app   3/3     3            3           27m   ctn-app        828370275182.dkr.ecr.us-west-2.amazonaws.com/tours:2.0   app=web
deployment.extensions/db    3/3     3            3           33m   ctn-tours-db   postgres:latest                                          app=db

NAME                       READY   STATUS    RESTARTS   AGE   IP           NODE                                       NOMINATED NODE   READINESS GATES
pod/app-7875fc4cb7-5nm7l   1/1     Running   0          28s   10.0.0.19    ip-10-0-0-179.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-ln9sj   1/1     Running   0          26s   10.0.3.201   ip-10-0-3-186.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-xbn7d   1/1     Running   0          25s   10.0.0.51    ip-10-0-0-231.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-9svrc    1/1     Running   0          33m   10.0.0.14    ip-10-0-0-231.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-hh48b    1/1     Running   0          33m   10.0.0.193   ip-10-0-0-179.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-tkv6l    1/1     Running   0          33m   10.0.3.146   ip-10-0-3-186.us-west-2.compute.internal   <none>           <none>
```
### Step 4: Oups! An issue with the latest release, I need to go back to previous
Kubernetes keep the latest deployment and I can rollback at any time
```
mewejp@MBPdeMEENEMESSE k8s-deployments % kubectl rollout undo deploy/app
deployment.extensions/app rolled back
mewejp@MBPdeMEENEMESSE k8s-deployments % kubectl get deploy,po -o wide  
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS     IMAGES                                                   SELECTOR
deployment.extensions/app   2/3     3            2           42m   ctn-app        828370275182.dkr.ecr.us-west-2.amazonaws.com/tours:1.0   app=web
deployment.extensions/db    3/3     3            3           72m   ctn-tours-db   postgres:latest                                          app=db

NAME                       READY   STATUS        RESTARTS   AGE     IP           NODE                                       NOMINATED NODE   READINESS GATES
pod/app-6c4fd6575b-hpfxz   1/1     Running       0          6s      10.0.0.99    ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/app-6c4fd6575b-jk9zh   1/1     Running       1          8s      10.0.1.91    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/app-6c4fd6575b-s9zxn   1/1     Running       0          4s      10.0.1.206   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-58jnj   0/1     Terminating   6          9m21s   10.0.1.25    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-nq9sx   0/1     Terminating   6          9m28s   10.0.1.114   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
pod/app-7875fc4cb7-xkmmn   0/1     Terminating   6          9m23s   10.0.0.180   ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/db-8645554dd6-78p9n    1/1     Running       0          72m     10.0.0.161   ip-10-0-0-82.us-west-2.compute.internal    <none>           <none>
pod/db-8645554dd6-vcm2n    1/1     Running       0          72m     10.0.1.99    ip-10-0-1-191.us-west-2.compute.internal   <none>           <none>
pod/db-8645554dd6-vvslr    1/1     Running       0          72m     10.0.1.131   ip-10-0-1-215.us-west-2.compute.internal   <none>           <none>
```
