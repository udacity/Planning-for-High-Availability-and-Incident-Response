terraform {
   backend "s3" {
     bucket = "udacity-tf-tscotto-west"
     key    = "terraform/terraform.tfstate"
     region = "us-west-1"
   }
 }