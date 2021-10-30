resource "aws_instance" "ubuntu" {
  ami           = 
  count = 
  instance_type = 
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = ""
  }
}

resource "aws_security_group" "ec2_sg" {
 
}