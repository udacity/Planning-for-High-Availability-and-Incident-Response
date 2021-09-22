resource "aws_security_group" "eks-cluster" {
  name        = "SG-eks-cluster"
  vpc_id      = var.vpc_id 

# Egress allows Outbound traffic from the EKS cluster to the  Internet 

  egress {                   # Outbound Rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
# Ingress allows Inbound traffic to EKS cluster from the  Internet 

  ingress {                  # Inbound Rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
resource "aws_eks_cluster" "cluster" {
   name     = "${var.name}-cluster"
   version  = "1.21"
   role_arn = var.cluster_role.arn

   vpc_config {
     security_group_ids = ["${aws_security_group.eks-cluster.id}"]
     subnet_ids = var.private_subnet_ids
   }

   # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
   # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
   depends_on = [
     aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
     aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
   ]
 }

 resource "aws_eks_node_group" "node" {
   cluster_name    = aws_eks_cluster.cluster.name
   node_group_name = "app-${var.name}-node-group"
   node_role_arn   = var.node_role.arn
   subnet_ids      = var.private_subnet_ids
   instance_types  = [var.instance_type]

   scaling_config {
     desired_size = var.nodes_desired_size
     max_size     = var.nodes_max_size
     min_size     = var.nodes_min_size
   }

   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
   depends_on = [
     aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
     aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
     aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
     aws_iam_role_policy_attachment.node_harmony_policy_attachment,
   ]

   tags = {
     Name = "eks-${var.name}-nodes"
   }
 }