pipeline {
    agent any
 
    tools {
        maven 'maven'
    }
    
    environment {
        TOMCAT_WEBAPPS = '/var/lib/tomcat9/webapps' // Set this to the actual path of the Tomcat webapps directory
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
        
        stage('Deploy index.jsp') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    def targetDir = "${TOMCAT_WEBAPPS}/ROOT"
                    def sourceJspPath = "https://raw.githubusercontent.com/giridharpatnaik183/webAppExample/master/src/main/webapp/index.jsp"

                    if (env.BRANCH_NAME == 'qa') {
                        sourceJspPath = "https://raw.githubusercontent.com/giridharpatnaik183/webAppExample/qa/src/main/webapp/index.jsp"
                    }

                    sh "curl -o ${targetDir}/index.jsp ${sourceJspPath}"
                }
            }
        }
    }
}
