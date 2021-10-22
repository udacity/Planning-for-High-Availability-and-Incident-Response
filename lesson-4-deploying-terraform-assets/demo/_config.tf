terraform {
   backend "s3" {
     bucket = "udacity-tf-tscotto6"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }
 }