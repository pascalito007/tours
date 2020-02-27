pipeline{
    agent any
    tools {
		maven 'Maven3'
		jdk 'JDK8'
	}
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
}