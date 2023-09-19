pipeline {
    agent any

    environment {
        PATH = "$PATH:/usr/share/maven/bin"
    }

    stages {
        stage('GetCode') {
            steps {
                git 'https://github.com/giridharpatnaik183/webAppExample.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh "mvn sonar:sonar"
                }
            }
        }
    }
}
