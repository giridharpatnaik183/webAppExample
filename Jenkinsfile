pipeline {
    agent any

    tools {
        maven 'maven'
    }

    environment {
        TOMCAT_WEBAPPS = '/var/lib/tomcat9/webapps' // Set this to the actual path of the Tomcat webapps directory
        SSH_CREDENTIALS = 'my_ssh_credentials'
        TOMCAT_SERVER = '54.89.78.184'
        TOMCAT_CREDENTIALS_ID = '058ddaec-e159-4481-b9e6-801f583943b6'
        TOMCAT_URL = 'http://54.89.78.184:8090/'
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
                    def targetDir
                    if (env.BRANCH_NAME == 'master') {
                        targetDir = "${TOMCAT_WEBAPPS}/master"
                    } else if (env.BRANCH_NAME == 'qa') {
                        targetDir = "${TOMCAT_WEBAPPS}/qa"
                    }
                    sshCommand remote: TOMCAT_SERVER, userSshKey: [$class: 'StringBinding', variable: 'SSH_CREDENTIALS'], command: "mkdir -p ${targetDir} && cp -f target/*.war ${targetDir}/"
                }
            }
        }

        stage('Deploy to Tomcat via Plugin') {
            steps {
                deploy adapters: [tomcat9(credentialsId: TOMCAT_CREDENTIALS_ID, path: '', url: TOMCAT_URL)], contextPath: null, war: '**/*.war'
            }
        }

        stage('Copy index.jsp') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                script {
                    def targetDir
                    def sourceJspPath
                    if (env.BRANCH_NAME == 'master') {
                        targetDir = "${TOMCAT_WEBAPPS}/ROOT"
                        sourceJspPath = "https://raw.githubusercontent.com/giridharpatnaik183/webAppExample/master/src/main/webapp/index.jsp"
                    } else if (env.BRANCH_NAME == 'qa') {
                        targetDir = "${TOMCAT_WEBAPPS}/qa"
                        sourceJspPath = "https://raw.githubusercontent.com/giridharpatnaik183/webAppExample/qa/src/main/webapp/index.jsp"
                    }

                    sshCommand remote: TOMCAT_SERVER, userSshKey: [$class: 'StringBinding', variable: 'SSH_CREDENTIALS'], command: "curl -o ${targetDir}/index.jsp ${sourceJspPath}"
                }
            }
        }
    }
}
