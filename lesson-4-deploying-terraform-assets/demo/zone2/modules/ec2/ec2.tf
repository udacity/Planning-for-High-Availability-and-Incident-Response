resource "aws_instance" "aws_linux" {
  ami           = var.aws_ami
  count         = var.instance_count
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "Web"
  }
}