# README - Terraform Deployment on AWS using Jenkins

This README describes the steps followed to set up an automated Terraform deployment on AWS using Jenkins. The process involves the creation of necessary Terraform configuration files, configuring Jenkins, and setting up a pipeline to provision AWS EC2 instances with a web server.

## Prerequisites

1. **AWS Account** - Ensure you have an AWS account set up.
2. **Jenkins Server** - Set up a Jenkins server, either on a local machine or an EC2 instance.
3. **GitHub Repository** - A GitHub repository that contains the Terraform files for infrastructure deployment.

## Steps Followed

### 1. Launching EC2 Instance

We launched an EC2 instance with Free Tier specifications.

### 2. Created Terraform Configuration Files

The following Terraform files were created and pushed to the GitHub repository:

- **provider.tf**: 
  Configures the AWS provider with the region "us-east-1".

- **main.tf**:
  Defines an AWS EC2 instance resource with specific tags, AMI, instance type, and security group settings. It also includes a user data script that installs a basic web server.

- **variables.tf**:
  Contains variables like instance name, AMI ID, instance type, and instance count.

- **security.tf**:
  Defines a security group allowing HTTP (port 80) and SSH (port 22) access.

- **Terraform Jenkinsfile**:
  This file defines the stages of the Jenkins pipeline which will automate the Terraform deployment process. The pipeline performs the following tasks:
  - Checkout code from GitHub repository.
  - Install Terraform if it's not already installed.
  - Initialize Terraform.
  - Generate a Terraform plan.
  - Apply the Terraform plan to deploy infrastructure.

### 3. Pushing Files to GitHub

After creating the above files, we pushed them to a GitHub repository (`https://github.com/satishflm/DevOps_Practice.git`).

### 4. Modifying the `visudo` File

In Jenkins, to allow the Jenkins user to run commands with `sudo` without a password prompt, we modified the `visudo` file using the following command:

```bash
sudo visudo
```

We added the following line at the end of the file:

```
jenkins ALL=(ALL) NOPASSWD:ALL
```

### 5. Setting Up Jenkins

1. **Access Jenkins**: Open Jenkins in a web browser using the public IP of the EC2 instance where Jenkins was installed.
2. **Adding AWS Credentials**:
   - Navigate to `Jenkins > Manage Jenkins > Credentials > Global > Add Credentials`.
   - Add the AWS credentials by specifying the `ID: aws-credentials`, `Access Key`, and `Secret Key`.
3. **Install Jenkins Plugins**:
   - Install the required Jenkins plugins: `Terraform` and `Pipeline: AWS Steps`.
   - Go to `Jenkins > Manage Jenkins > Manage Plugins > Available`.
   - Search for `Terraform` and `Pipeline: AWS Steps`, select them, and click "Install".

### 6. Creating a Jenkins Job

1. **Create a New Job**:
   - In Jenkins, create a new job with any name (e.g., `Terraform_Deploy`).
   - Add the description: **"Creates AWS EC2 Instance and sets up the webserver."**
2. **Configure the Job**:
   - Under the "Build Triggers" section, select "Don't allow concurrent builds."
   - In the "Pipeline" section, choose **"Pipeline script from SCM"**.
   - Set **SCM** to **Git** and provide the URL of the GitHub repository where the Terraform code is stored.
   - Provide your GitHub token (not your GitHub password) as the credentials for accessing the GitHub repository.
   - Specify the name of the `Jenkinsfile` (e.g., `Terraform.Jenkinsfile`).
3. **Save and Run**:
   - Save the job configuration.
   - Trigger the job by clicking **"Build Now"**.

### 7. Jenkins Pipeline Execution

- The pipeline will:
  - Checkout the code from the GitHub repository.
  - Install Terraform if it’s not already installed.
  - Initialize Terraform.
  - Generate a Terraform plan.
  - Apply the plan to provision the EC2 instance and set up the web server.

### 8. Expected Outcome

Once the pipeline completes successfully:
- An EC2 instance will be created in the **us-east-1** region.
- The instance will have a web server (Apache) installed and running.
- You should be able to access the instance's public IP in a browser and see "Hello, World!" as the web page.

---

## Conclusion

This guide walks you through the process of automating AWS EC2 instance creation and configuration with Jenkins and Terraform. The process includes creating Terraform files, setting up Jenkins, and triggering a pipeline to deploy the infrastructure. After following the steps, you should have a fully automated environment for provisioning EC2 instances with a web server.

Feel free to modify the configurations based on your needs, such as changing the instance type, region, or adding more resources to your infrastructure.
