 module "vpc" {
   source     = "./modules/vpc"
   cidr_block = "10.100.0.0/16"
   name       = "udacity-rds"
   azs           = ["us-east-2a", "us-east-2b", "us-east-2c"]
 }

  module "vpc_west" {
   source     = "./modules/vpc"
   cidr_block = "10.100.0.0/16"
   name       = "udacity-rds-west"
   azs           = ["us-west-1b", "us-west-1c"]
  providers = {
    aws = aws.usw1
  }
 }

output "vpc_id" {
   value = module.vpc_west.vpc_id
 }

 output "private_subnet_ids" {
   value = module.vpc_west.private_subnet_ids
 }

 output "public_subnet_ids" {
   value = module.vpc_west.public_subnet_ids
 }