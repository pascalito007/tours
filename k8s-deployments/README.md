# kubernetes deployments specifications
## Project  files
1. `tours-app-deployment.yml` The front-end app deployment specification + Loadbalancer service
2. `tours-db-deployement.yml` The database deployment specification + NodePort service

## Apply configMap
Run: `Kubectl apply -f tours-web-and-db-cm.yaml`
## Deploy California tours app database
Run: `Kubectl apply -f tours-db-deployment.yml`
## Deploy California tours app front-end app
Run `Kubectl apply -f tours-app-deployment.yml`
