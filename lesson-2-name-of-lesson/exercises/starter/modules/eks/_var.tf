variable "name" {}
 variable "account" {}
 variable "private_subnet_ids" {}
 variable "vpc_id" {}
 variable "ec2_sg" {}
 variable "instance_type" {
   description = "EC2 instance type to use for the argo EC2 instances."
   default     = "t3.medium"
 }

 variable "nodes_desired_size" {
   description = "The desired number of EC2 instances."
   default     = 2
 }

 variable "nodes_max_size" {
   description = "The maximum number of EC2 instances to run."
   default     = 5
 }

 variable "nodes_min_size" {
   description = "The minimum number argo EC2 instances to run."
   default     = 2
 }

 variable "tags" {
   default = {}
 }