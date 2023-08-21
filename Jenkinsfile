pipeline {
    agent any

 

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the repository
                checkout scm
            }
        }

 

        stage('Build') {
            matrix {
                axes {
                    axis {
                        name 'BRANCH'
                        values 'master', 'qa' // Add more branch names as needed
                    }
                }
                stages {
                    stage('Build and Test') {
                        steps {
                            script {
                                def branchName = "${env.BRANCH}"

 

                                // Assuming your application is Maven-based
                                sh "mvn clean install -DskipTests=true -P${branchName}"
                            }
                        }
                    }
                }
            }
        }

 

        stage('Deploy to Tomcat') {
            matrix {
                axes {
                    axis {
                        name 'BRANCH'
                        values 'master', 'qa' // Add more branch names as needed
                    }
                }
                stages {
                    stage('Deploy') {
                        steps {
                            script {
                                def branchName = "${env.BRANCH}"

 

                                // Deploy to Tomcat
								deploy adapters: [tomcat9(credentialsId: '058ddaec-e159-4481-b9e6-801f583943b6', path: '', url: 'http://18.234.157.123:8090/')], contextPath: null, war: '**/*.war'
                            }
                        }
                    }
                }
            }
        }
    }
}
