pipeline {
    agent any
    
    environment {
        PYTHON = 'python'
        PIP = 'pip'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/LXXPK/Expense_tracker.git'
            }
        }
        
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
                    withCredentials([string(credentialsId: 'dockerhub-credentials', variable: 'DOCKER_PASSWORD')]) {
                        bat "docker login -u yourusername -p %DOCKER_PASSWORD%"
                        bat 'docker push expense-tracker:latest'
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
