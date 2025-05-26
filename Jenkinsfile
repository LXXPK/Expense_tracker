pipeline {
    agent any
    
    environment {
        PYTHON = 'C:\\Python312\\python.exe'   // Adjust this path based on your installation
        PIP = 'C:\\Python312\\Scripts\\pip.exe'
        IBM_CLOUD_API_KEY = credentials('ibmcloud-apikey-id') 
    }
    
    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    bat "${PIP} install -r requirements.txt"
                }
            }
        }
        
        stage('Run Unit Tests') {
            steps {
                script {
                    bat "${PYTHON} manage.py test home"
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t icr.io/expense/expense-tracker:latest .'
                }
            }
        }
        
        // stage('Push to Docker Hub') {
        //     steps {
        //         script {
        //            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
        //                 bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
        //                 bat 'docker tag expense-tracker:latest %DOCKER_USERNAME%/expense-tracker:latest'  // Tag the image
        //                 bat 'docker push %DOCKER_USERNAME%/expense-tracker:latest'  // Push the tagged image
        //             }
        //         }
        //     }
        // }

        stage('Login to IBM Cloud') {
            steps {
                script {
                    bat 'ibmcloud login --apikey %IBM_CLOUD_API_KEY%'
                    bat 'ibmcloud cr login'
                }
            }
        }
        stage('Publish Docker Images to IBM Cloud Registry') {
            steps {
                script {
                    bat 'docker push icr.io/expense/expense-tracker:latest'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
