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

        stage('Modify Sudoers for Jenkins') {
            steps {
                sh '''
                echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
                '''
            }
        }

        stage('Install Terraform') {
            steps {
                sh '''
                if ! command -v terraform &> /dev/null
                then
                    echo "Terraform not found, installing..."
                    sudo -i yum install -y yum-utils shadow-utils
                    sudo -i yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
                    sudo -i yum -y install terraform
                    terraform --version
                    
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
