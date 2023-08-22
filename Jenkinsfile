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
        
        stage('Build and Deploy') {
            matrix {
                axes {
                    axis {
                        name 'BRANCH'
                        values 'master', 'qa'
                    }
                }
                stages {
                    stage('Build') {
                        steps {
                            sh 'mvn clean package'
                        }
                    }
                    stage('Deploy to Tomcat Server') {
                        steps {
                            script {
                                def targetDir = "${TOMCAT_WEBAPPS}/${BRANCH}"
                                sh "mkdir -p ${targetDir}"
                                sh "cp -f target/*.war ${targetDir}/" // Copy the WAR file to the Tomcat webapps directory
                            }
                        }
                    }
                    stage('Copy index.jsp') {
                        steps {
                            script {
                                def targetDir = "${TOMCAT_WEBAPPS}/${BRANCH}"
                                def sourceJspPath = "https://raw.githubusercontent.com/giridharpatnaik183/webAppExample/${BRANCH}/src/main/webapp/index.jsp"
                                sh "curl -o ${targetDir}/index.jsp ${sourceJspPath}"
                            }
                        }
                    }
                }
            }
        }
    }
}
