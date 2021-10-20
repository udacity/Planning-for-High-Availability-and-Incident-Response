resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  vpc_id      = var.vpc_id

  ingress {    
    description = "web port"
    from_port   = 80    
    to_port     = 80
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh port"
    from_port   = 22    
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "monitoring"
    from_port   = 9100    
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}