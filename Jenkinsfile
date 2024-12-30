pipeline {
    agent any
    
    environment {
        PYTHON = 'python'
        PIP = 'pip'
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
                    bat 'docker build -t expense-tracker:latest .'
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                   withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                        bat 'docker tag expense-tracker:latest %DOCKER_USERNAME%/expense-tracker:latest'  // Tag the image
                        bat 'docker push %DOCKER_USERNAME%/expense-tracker:latest'  // Push the tagged image
                    }
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
