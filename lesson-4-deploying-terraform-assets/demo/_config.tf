terraform {
   backend "s3" {
     bucket = "udacity-tf-tscotto-west"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }
 }