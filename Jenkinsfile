pipeline{
    agent any
    stages{
        stage('checkout'){
            steps{
                deleteDir()
                checkout scm
            }
        }
        stage('unit test'){
            steps{
                echo "========always========"
                // scrip{
                //     sh "mvn clean install -Dmaven.test.skip=false"
                // }
            }
        }
    }
}