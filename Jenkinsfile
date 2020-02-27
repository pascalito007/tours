pipeline{
    agent any
    stages{
        stage("checkout"){
            steps{
                deleteDir()
                checkout scm
            }
        }
        stage("unit test"){
            steps{
                scrip{
                    sh "mvn clean install -Dmaven.test.skip=false"
                }
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}