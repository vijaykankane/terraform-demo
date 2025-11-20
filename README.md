# Creating infrastructure by Terraform and deploying MERN application by ansible
Part 1: Infrastructure Setup with Terraform

1. AWS Setup and Terraform Initialization:

   - Configure AWS CLI and authenticate with your AWS account. aws cli install on the laptop and aws configure has been set with Access key ID	Secret access key

   - Initialize a new Terraform project targeting AWS. 
   use command terraform init to initalize teh terraform

2. VPC and Network Configuration: terraform plan followed by terraform apply --auto-approval inside tfcode folder 

   - Create an AWS VPC with two subnets: one public and one private. 
   - Set up an Internet Gateway and a NAT Gateway. 
   - Configure route tables for both subnets. 
![alt text](image/NAT-IGW-RT.png)

3. EC2 Instance Provisioning:

   - Launch two EC2 instances: one in the public subnet (for the web server) and another in the private subnet (for the database).
   ![alt text](image/Ec2.png)




   - Ensure both instances are accessible via SSH (public instance only accessible from your IP). its configurable and open from user IP only while running the terraform apply command its taken care in the variable.

![alt text](image/sg.png)

4. Security Groups and IAM Roles:

   - Create necessary security groups for web and database servers. added 5000/3000 for the applcation acess , for the private instance allowed 22 within same security group only from public instance though key.
   
![alt text](image/sg.png)


   - Set up IAM roles for EC2 instances with required permissions.
![alt text](image/iamRole.png)

5. Resource Output:

   - Output the public IP of the web server EC2 instance and ansible
   ![alt text](image/terraformFInalOutput.png)

1. Ansible Configuration:

   Creating the EC2 by above terraform script as ansible master and with the help user data we are installing the ansible though apt, plese refer maint.tf under modules/ec2 for more details

![alt text](image/ansibleInstallation.png)

Configure both DB and WEB server in the hosts.inin file and tranfer teh pem key to the master server through winscp.

Test the connectivity of both web and DB server from ansible master node 

![alt text](image/DB-WEB-connectedfromAnsible.png)


2. Web Server Setup by installing the depedecy and applcation 

![alt text](image/web-depedency-node-pm2.png)

3. Database Server Setup:
   Refer db.yml for more details 
  ![alt text](image/Dbinstallation.png)

 
4. Application Deployment:
   
    Refer app-deploy.yml for all details

![alt text](image/applicationDeployment.png)
     ![alt text](image/frontendWorkingFine.png)

![alt text](image/backendworkingfine.png)
5. Security Hardening:

   SSH only allowed from the ips in the same VPC and same security group. DB accessbile only from the same security group only not allowed from public.

Common command used are
ansible-playbook -i hosts.ini <playbook name>



