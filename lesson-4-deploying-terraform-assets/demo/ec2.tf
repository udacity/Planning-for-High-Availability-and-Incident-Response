  module "project_ec2" {
   source             = "./modules/ec2"
   instance_count     = 2
   aws_ami            = "ami-0b9064170e32bde34"
   public_subnet_ids  = module.vpc.public_subnet_ids
 }