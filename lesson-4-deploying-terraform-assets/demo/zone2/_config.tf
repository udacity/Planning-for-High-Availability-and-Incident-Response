terraform {
   backend "s3" {
     bucket = "udacity-tf-tscotto2"
     key    = "terraform/terraform.tfstate"
     region = "us-west-1"
   }
 }