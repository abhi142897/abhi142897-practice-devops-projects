AWS infra automation project:

Problem Statement
The goal of this Terraform project is to automate the deployment of a basic infrastructure on AWS that includes a Virtual Private Cloud (VPC), subnets, security groups, instances, an application load balancer (ALB), and an S3 bucket. The challenge is to ensure that these resources are properly configured to work together while utilizing Terraform's modularity and variable management features for flexibility and scalability.

Solution Approach
The solution involves creating a structured Terraform configuration that utilizes variables and .tfvars files to manage environment-specific settings. The infrastructure will be modularized using the following components:

VPC: To define a private network for resources.
Subnets: To segment the VPC into public and private areas.
Internet Gateway: To allow external access to the VPC.
Route Table: To define routing rules for the network traffic.
Security Groups: To control inbound and outbound traffic to the resources.
EC2 Instances: To deploy application servers within the subnets.
Load Balancer: To distribute traffic among the instances.
S3 Bucket: To provide object storage.
Steps to Implement the Solution
Setup Terraform Files:

main.tf: Define the primary resources (VPC, subnets, security groups, EC2 instances, ALB, and S3 bucket).
variables.tf: Define the input variables used for configurations, including VPC CIDR block, subnet configurations, instance details, and S3 bucket name.
terraform.tfvars: Provide values for the variables defined in variables.tf, allowing for easy adjustments based on different environments.

Define the VPC:
Create a VPC with a specified CIDR block.
Ensure it has the necessary settings to facilitate public and private subnets.
Create Subnets:

Define public and private subnets that utilize the VPC ID for proper association.
Configure Networking:

Add an internet gateway to allow internet access.
Create a route table and associate it with the public subnets to define outbound internet traffic rules.
Establish Security Groups:

Create security groups to manage traffic rules for incoming and outgoing connections (e.g., allowing HTTP and SSH traffic).
Deploy EC2 Instances:

Launch EC2 instances in the specified subnets using the details provided in the terraform.tfvars.
Setup Application Load Balancer:

Create an ALB to manage traffic distribution across the EC2 instances.
Define target groups and listener configurations for the ALB.
Create S3 Bucket:

Provision an S3 bucket for object storage.
Output Configuration:

Define output values, such as the DNS name of the load balancer, to provide useful information after deployment.
Run Terraform Commands:

Initialize the Terraform workspace using terraform init.
Validate the configuration with terraform validate.
Plan and Apply the configuration to provision the infrastructure with terraform apply.
The output will show load balancer dns. Using the same we can accessthe application UI.