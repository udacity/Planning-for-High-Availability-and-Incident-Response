resource "aws_instance" "ubuntu" {
  ami           = var.ami_aws
  count = var.count
  instance_type = var.instance_type
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Web"
  }
}

resource "aws_security_group" "ec2_sg" {
 name = "ec2_sg"
 instance_type = var.instance_type
 ingress = {
  from_port = "80"
  to_port = "80"
 }
 ingress = {
  from_port = "22"
  to_port = "22"
 }
 tags = {
  Name = "ec2_sg"
 }
}