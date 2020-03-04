# kubernetes deployments specifications
## Project  files
1. `tours-app-deployment.yml` Kubernetes deployment specification that deploy front-end app
using ECR image and accessible outside using loadbalancer type service
2. `tours-db-deployement.yml` The database used by front-end to show california tours
 informations
## Deploy California tours app database
I am using the latest postgres image to create the database and NodePort type service. Run below command
`Kubectl apply -f tours-db-deployment.yml`
## Deploy California tours app front-end app
Run `Kubectl apply -f tours-app-deployment.yml` that deploy the front end app with service
and make it available outside using loadbalancer
