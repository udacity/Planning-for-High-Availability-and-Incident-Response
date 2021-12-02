data "aws_caller_identity" "current" {}

 data "aws_ami" "amazon_linux_2" {
   most_recent = true
   owners      = ["amazon"]

   filter {
     name   = "owner-alias"
     values = ["amazon"]
   }


   filter {
     name   = "name"
     values = ["amzn2-ami-hvm*"]
   }
 }

data "terraform_remote_state" "vpc" {
  backend = "s3" 
  config = {
     bucket = "udacity-tf-<your_name>"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }


}

data "aws_iam_policy" "instance-policy" {
  name = "app-udacity-instance-policy"
}

data "aws_iam_policy" "cloudwatch-policy" {
  name = "app-udacity-eks-cluster-role-cloudwatch-policy"
}

data "aws_iam_role" "eks_cluster_role" {
  name = "app-udacity-eks-cluster-role"
}

data "aws_iam_role" "eks_node_role" {
  name = "app-udacity-eks-node-role"
}