pipeline{
    agent any

    tools {
		maven 'Maven3'
	}

    stages{
        stage('checkout'){
            steps{
                deleteDir()
                checkout scm
            }
        }
        stage('run unit test'){
            steps{
                sh "mvn clean install -Dmaven.test.skip=false"

            }
        }
        stage('build dockerfile and push to ecr'){
            steps{
                script{
                        docker.build('tours')
                        docker.withRegistry('https://828370275182.dkr.ecr.us-west-2.amazonaws.com', 'ecr:us-west-2:828370275182') {
                        docker.image('tours').push('2.0')
                    }
                }
            }
        }
        stage('deploy database'){
            steps{
                withAWS(region:'us-west-2',credentials:'828370275182') {
                    script{
                        "export AWS_PROFILE=clusterAdmin"
                        "aws eks update-kubeconfig --name eks-cluster"
                        "kubectl apply -f ./k8s-deployments/tours-web-and-db-cm.yml"
                        "kubectl apply -f ./k8s-deployments/tours-db-deployment.yml"
                    }
                }
                
                
            }
        }
        stage('deploy front app'){
            steps{
                withAWS(region:'us-west-2',credentials:'828370275182') {
                    script{
                        "kubectl apply -f ./k8s-deployments/tours-app-deployment.yml"
                        "kubectl get no -o wide"
                        "kubectl get all -o wide"
                    }
                }
            }
        }
    }
    post{
        success{
            echo "====++++Successfully deployed++++===="
        }
    }
}
