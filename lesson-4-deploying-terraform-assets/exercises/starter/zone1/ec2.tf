  module "project_ec2" {
   source             = "./zone1/ec2"
   instance_count     = 2
   name               = local.name
   account            = data.aws_caller_identity.current.account_id
   aws_ami            = "ami-0b9064170e32bde34"
   private_subnet_ids = module.vpc.private_subnet_ids
   public_subnet_ids  = vpc.public_subnet_ids
   vpc_id             = vpc.vpc_id
 }