terraform {
   backend "s3" {
     bucket = "udacity-tf-tscotto"
     key    = "terraform/terraform.tfstate"
     region = "us-east-1"
   }
 }

 provider "aws" {
   region = "us-east-1"
   
 }

 provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}