locals {
   account_id = data.aws_caller_identity.current.account_id

   name   = "udacity"
   region = "us-west-1"
   tags = {
     Name      = local.name
     Terraform = "true"
   }
 }

 module "vpc" {
   source     = "./modules/vpc"
   cidr_block = "10.100.0.0/16"

   account_owner = local.name
   name          = "${local.name}-project"
   azs           = ["us-west-1b", "us-west-1c"]
   private_subnet_tags = {
     "kubernetes.io/role/internal-elb" = 1
   }
   public_subnet_tags = {
     "kubernetes.io/role/elb" = 1
   }
 }