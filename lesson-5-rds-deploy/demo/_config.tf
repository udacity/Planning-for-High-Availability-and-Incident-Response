terraform {
   backend "s3" {
     bucket = "udacity-sre-terraform-testing" # Replace it with your S3 bucket name
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }
 }

 provider "aws" {
   region = "us-east-2"
   
 }

 provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}