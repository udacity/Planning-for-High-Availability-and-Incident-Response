resource "aws_rds_cluster_parameter_group" "cluster_pg" {
  name   = "udacity-pg-p"
  family = "aurora5.6"

  parameter {
    name  = "binlog_format"    
    value = "MIXED"
    apply_method = "pending-reboot"
  }

  parameter {
    name = "log_bin_trust_function_creators"
    value = 1
    apply_method = "pending-reboot"
  }
}

resource "aws_db_subnet_group" "udacity_db_subnet_group" {
  name       = "udacity_db_subnet_group"
  subnet_ids = var.private_subnet_ids

}
resource "aws_rds_cluster" "udacity_cluster" {
  cluster_identifier       = "udacity-db-cluster"
  availability_zones       = {}
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_pg.name
  database_name            = "udacityc2"
  master_username          = "udacity"
  master_password          = "MyUdacityPassword"
  vpc_security_group_ids   = [aws_security_group.db_sg_1.id]
  db_subnet_group_name     = aws_db_subnet_group.udacity_db_subnet_group.name
  engine_mode              = "provisioned"
  engine_version           = "5.6.mysql_aurora.1.19.1" 
  skip_final_snapshot      = true
  storage_encrypted        = false
  depends_on = [aws_rds_cluster_parameter_group.cluster_pg]
}

output "db_cluster_arn" {
  value = aws_rds_cluster.udacity_cluster.arn
}

output "db_instance_arn" {
  value = aws_rds_cluster_instance.udacity_instance[1].arn
}

resource "aws_rds_cluster_instance" "udacity_instance" {
  count                = 2
  identifier           = "udacity-db-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.udacity_cluster.id
  instance_class       = "db.t2.small"
  db_subnet_group_name = aws_db_subnet_group.udacity_db_subnet_group.name
}

resource "aws_security_group" "db_sg_1" {
  name   = "udacity-db-sg"
  vpc_id =  var.vpc_id

  ingress {
    from_port   = 3306
    protocol    = "TCP"
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 3306
    protocol    = "TCP"
    to_port     = 3306
    cidr_blocks = ["0.0.0.0/0"]
  }
}