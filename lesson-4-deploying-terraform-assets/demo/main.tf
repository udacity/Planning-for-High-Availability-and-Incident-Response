locals {
   account_id = data.aws_caller_identity.current.account_id

   name   = "udacity"
   region = "us-east-2"
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
   azs           = ["us-east-2a", "us-east-2b", "us-east-2c"]
 }