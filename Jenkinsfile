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
                        docker.image('tours').push('1.0')
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
