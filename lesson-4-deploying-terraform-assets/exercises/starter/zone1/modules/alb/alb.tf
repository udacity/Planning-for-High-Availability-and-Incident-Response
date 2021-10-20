# resource "aws_lb_target_group" "udacity" {
#   name     = "udacity-lb-tg"
#   port     = 
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id
# }

# resource "aws_lb_target_group_attachment" "udacity" {
#   count            = 2
#   target_group_arn = aws_lb_target_group.udacity.arn
#   target_id        = var.ec2.*.id[count.index]
#   port             = 
# }

# resource "aws_lb" "udacity" {
#   name               = "udacity-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [var.ec2_sg]
#   subnets            = var.subnet_id

#   enable_deletion_protection = false

# }

# resource "aws_lb_listener" "udacity" {
#   load_balancer_arn = aws_lb.udacity.arn
#   port              = ""
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.udacity.arn
#   }
# }