  module "project_ec2" {
   source             = "./modules/ec2"
   instance_count     = 2
   aws_ami            = "ami-0e0bf4b3a0c0e0adc"
   public_subnet_ids  = module.vpc.public_subnet_ids
 }