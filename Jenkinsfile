pipeline {
    agent any
    
    tools {
        maven 'maven'
    }
    
    stages {
        stage('SCM Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master'], [name: '*/qa']], userRemoteConfigs: [[url: 'https://github.com/giridharpatnaik183/webAppExample.git']]])
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Deploy to Tomcat Server') {
            steps {
                deploy adapters: [tomcat9(credentialsId: '058ddaec-e159-4481-b9e6-801f583943b6', path: '', url: 'http://18.234.157.123:8090/')], contextPath: null, war: '**/*.war'
            }
        }
    }
}
