pipeline{
	agent any
tools{
	maven 'maven'
}
	
	stages{

	stage('SCM Checkout'){

	steps{
	git branch: 'master', url: 'https://github.com/aishwaryasomashekar/webAppExample.git'
	}
	} 
stage('Build'){

	steps{
	sh 'mvn clean package'
	}
	} 
stage ('Deploy to Tomcat Server'){
			steps{
				deploy adapters: [tomcat9(credentialsId: 'abd0586d-0f34-4d69-bc82-b1b9194bc521', path: '', url: 'http://13.236.84.153:8090/')], contextPath: 'webAppExample', war: '**/*.war'
			}

		}
	
	}
	}
