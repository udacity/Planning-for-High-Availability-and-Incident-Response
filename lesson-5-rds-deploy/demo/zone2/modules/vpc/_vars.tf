variable "name" {}
 variable "cidr_block" {}

 variable "azs" {
   type = list(string)
 }

 variable "public_subnet_tags" {
   default = {}
 }

 variable "private_subnet_tags" {
   default = {}
 }

 variable "account_owner" {
   default = ""
 }