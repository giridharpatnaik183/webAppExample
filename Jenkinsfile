pipeline {
    agent any

    tools {
        maven 'maven'
    }

    environment {
        TOMCAT_WEBAPPS = '/var/lib/tomcat9/webapps' // Set this to the actual path of the Tomcat webapps directory
        SSH_CREDENTIALS = 'my_ssh_credentials'
        TOMCAT_SERVER = '54.89.78.184'
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
                    def targetDir = "${TOMCAT_WEBAPPS}/${BRANCH}"
                    sshCommand remote: TOMCAT_SERVER, userSshKey: [$class: 'StringBinding', variable: 'SSH_CREDENTIALS'], command: "mkdir -p ${targetDir} && cp -f target/*.war ${targetDir}/"
                }
            }
        }

        stage('Copy index.jsp') {
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

                    sshCommand remote: TOMCAT_SERVER, userSshKey: [$class: 'StringBinding', variable: 'SSH_CREDENTIALS'], command: "curl -o ${targetDir}/index.jsp ${sourceJspPath}"
                }
            }
        }
    }
}
