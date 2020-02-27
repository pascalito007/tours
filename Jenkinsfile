pipeline{
    agent any
    stages{
        stage("checkout"){
            deletedir()
            checkout scm
        }
        stage("unit test"){
            sh "mvn clean install -Dmaven.test.skip=false"
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