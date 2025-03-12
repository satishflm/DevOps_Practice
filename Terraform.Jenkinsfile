pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-credentials')  
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/sai2k21/Devops-infra-exercise.git'
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                if ! command -v terraform &> /dev/null
                then
                    echo "Terraform not found, installing..."
                    curl -LO https://releases.hashicorp.com/terraform/1.4.0/terraform_1.4.0_linux_amd64.zip
                    unzip -o terraform_1.4.0_linux_amd64.zip
                    mkdir -p /var/lib/jenkins/bin
                    mv terraform /var/lib/jenkins/bin/
                    
                else
                    echo "Terraform is already installed"
                fi
                export PATH=/var/lib/jenkins/bin:$PATH
                terraform --version
                '''
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
