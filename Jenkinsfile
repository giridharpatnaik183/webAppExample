pipeline {
    agent any
     
    tools {
        maven 'maven'
    }
    
    environment {
        TOMCAT_WEBAPPS = '/var/lib/tomcat9/webapps'
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
                script {
                    def targetDir = "${TOMCAT_WEBAPPS}/${env.BRANCH_NAME}"
                    sh "mkdir -p ${targetDir}"
                    sh "cp -f target/*.war ${targetDir}/" // Copy the WAR file to the Tomcat webapps directory
                }
                deploy adapters: [tomcat9(credentialsId: '058ddaec-e159-4481-b9e6-801f583943b6', path: "/${env.BRANCH_NAME}", url: 'http://54.89.78.184:8090/')], contextPath: null, war: '**/*.war'
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
