# In the above code, make sure to replace <your-access-key> and <your-secret-access-key> with your own AWS access key and secret access key. Also, update the ami parameter with the desired AMI ID for your instances.
# You can save this code in a file with a .tf extension (e.g., ec2-instances.tf). Then, initialize Terraform by running terraform init in the directory where the file is located. After initialization, you can deploy the EC2 instances by running terraform apply. Terraform will prompt for confirmation before creating any resources.
# Note: Remember to have the AWS CLI installed and configured on your system with appropriate permissions for the access key you provide.


provider "aws" {
  access_key = "<your-access-key>"
  secret_access_key = "<your-secret-access-key>"
  region = "us-east-1" # Change to your desired region
}

resource "aws_instance" "ec2_instance1" {
  ami           = "ami-12345678"  # Change to your desired AMI ID
  instance_type = "t2.micro"
  count         = 1
  tags = {
    Name = "EC2 Instance 1"
  }
}

resource "aws_instance" "ec2_instance2" {
  ami           = "ami-12345678"  # Change to your desired AMI ID
  instance_type = "t2.micro"
  count         = 1
  tags = {
    Name = "EC2 Instance 2"
  }
}
