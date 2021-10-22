###################
 # Internet Gateway
 ###################
 resource "aws_internet_gateway" "this" {
   count = length(var.azs) > 0 ? 1 : 0

   vpc_id = aws_vpc.this.id

   tags = merge(
     {
       "Name" = format("%s", var.name)
     }
   )
 }

 # Publiс routes
 resource "aws_route_table" "public" {
   count = length(var.azs) > 0 ? 1 : 0

   vpc_id = aws_vpc.this.id

   tags = merge(
     {
       "Name" = format("%s-public", var.name)
     }
   )
 }

 resource "aws_route" "public_internet_gateway" {
   count = length(var.azs) > 0 ? length(var.azs) : 0

   route_table_id         = aws_route_table.public[0].id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id             = aws_internet_gateway.this[0].id

   timeouts {
     create = "5m"
   }
 }

 ##############
 # NAT Gateway
 ##############
 locals {
   nat_gateway_count = 1
   nat_gateway_ips = split(
     ",", join(",", aws_eip.nat.*.id),
   )
 }

 resource "aws_eip" "nat" {
   count = local.nat_gateway_count

   vpc = true

   tags = merge(
     {
       "Name" = format(
         "%s-%s",
         var.name,
         element(var.azs, count.index),
       )
     }
   )
 }

 resource "aws_nat_gateway" "this" {
   count = local.nat_gateway_count

   allocation_id = element(
     local.nat_gateway_ips,
     count.index,
   )
   subnet_id = element(
     aws_subnet.public.*.id,
     count.index,
   )

   tags = merge(
     {
       "Name" = format(
         "%s-%s",
         var.name,
         element(var.azs, count.index),
       )
     }
   )

   depends_on = [aws_internet_gateway.this]
 }

 resource "aws_route" "private_nat_gateway" {
   count = length(var.azs)

   route_table_id         = element(aws_route_table.private.*.id, count.index)
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)

   timeouts {
     create = "5m"
   }
 }

 # Private routes
 # There are as many routing tables as the number of NAT gateways
 resource "aws_route_table" "private" {
   count = length(var.azs) > 0 ? length(var.azs) : 0

   vpc_id = aws_vpc.this.id

   tags = merge(
     {
       "Name" = format("%s-private-%s", var.name, element(var.azs, count.index),
       )
     }
   )

   lifecycle {
     # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
     # resources that manipulate the attributes of the routing table (typically for the private subnets)
     ignore_changes = [propagating_vgws]
   }
 }

 # Route table association
 ##########################
 resource "aws_route_table_association" "private" {
   count = length(var.azs) > 0 ? length(var.azs) : 0

   subnet_id      = element(aws_subnet.private.*.id, count.index)
   route_table_id = element(aws_route_table.private.*.id, count.index)
 }

 resource "aws_route_table_association" "public" {
   count = length(var.azs) > 0 ? length(var.azs) : 0

   subnet_id      = element(aws_subnet.public.*.id, count.index)
   route_table_id = aws_route_table.public[0].id
 }