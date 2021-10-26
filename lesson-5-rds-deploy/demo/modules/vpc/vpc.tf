resource "aws_vpc" "this" {
   cidr_block           = var.cidr_block
   enable_dns_hostnames = true
   enable_dns_support   = true
   tags = merge(
     {
       "Name" = format("%s", var.name)
     }
   )
 }

 # Private subnet
 resource "aws_subnet" "private" {
   count = length(var.azs) > 0 ? length(var.azs) : 0

   vpc_id            = aws_vpc.this.id
   cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, 1 + count.index)
   availability_zone = element(var.azs, count.index)

   tags = merge(
     {
       "Name" = format(
         "%s-private-%s",
         var.name,
         element(var.azs, count.index),
       )
     },
     var.private_subnet_tags
   )
 }

 # Public subnet
 resource "aws_subnet" "public" {
   count = length(var.azs) > 0 ? length(var.azs) : 0

   vpc_id                  = aws_vpc.this.id
   cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, 10 + count.index)
   availability_zone       = element(var.azs, count.index)
   map_public_ip_on_launch = true

   tags = merge(
     {
       "Name" = format(
         "%s-public-%s",
         var.name,
         element(var.azs, count.index),
       )
     },
     var.public_subnet_tags
   )
 }