provider "aws" {
  access_key = "<your-access-key>"
  secret_access_key = "<your-secret-access-key>"
  region = "us-east-1" # Change to your desired region
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.21"  # Change to your desired EKS version

  vpc_config {
    subnet_ids         = ["subnet-12345678", "subnet-abcdefgh"]  # Replace with your subnet IDs
    security_group_ids = ["sg-12345678"]  # Replace with your security group ID
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}
