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
                sh "mvn clean install -Dmaven.test.skip=true"

            }
        }
        stage('build dockerfile and push to ecr'){
            steps{
                script{
                        docker.build('travel')
                        docker.withRegistry('https://828370275182.dkr.ecr.eu-west-3.amazonaws.com', 'ecr:eu-west-3:828370275182') {
                        docker.image('travel').push('1.0')
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
