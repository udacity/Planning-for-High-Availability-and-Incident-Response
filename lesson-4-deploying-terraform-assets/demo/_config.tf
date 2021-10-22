terraform {
   backend "s3" {
     bucket = "udacity-tf-tscotto7"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }
 }