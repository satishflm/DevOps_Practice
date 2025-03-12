pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('701b34ca-0b22-4200-b694-4022b8b819ee')  
        AWS_SECRET_ACCESS_KEY = credentials('701b34ca-0b22-4200-b694-4022b8b819ee')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/sai2k21/Devops-infra-exercise.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment successful!'
        }
        failure {
            echo 'Terraform deployment failed!'
        }
    }
}
