# -------------  EKS API Server  ----------------------

  data "aws_iam_policy_document" "eks_assume_role_policy" {
   statement {
     actions = ["sts:AssumeRole"]

      principals {
       type        = "Service"
       identifiers = ["eks.amazonaws.com"]
     }
   }
 }

#   resource "aws_iam_role" "eks_cluster_role" {
#    name               = "app-${var.name}-eks-cluster-role"
#    assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
#  }

  resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
   role       = "app-udacity-eks-cluster-role"
 }

  resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSServicePolicy" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
   role       = "app-udacity-eks-cluster-role"
 }

  # --------- EKS NODE ---------------------

  data "aws_iam_policy_document" "eks_node_assume_role_policy" {
   statement {
     actions = ["sts:AssumeRole"]

      principals {
       type        = "Service"
       identifiers = ["ec2.amazonaws.com"]
     }
   }
 }

#   resource "aws_iam_role" "eks_node_cluster_role" {
#    name               = "app-${var.name}-eks-node-role"
#    assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json
#  }

  resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSCloudwatchPolicy" {
   role       = "app-udacity-eks-node-role"
   policy_arn = var.cloudwatch_policy.arn
 }

  resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
   role       = "app-udacity-eks-node-role"
 }

  resource "aws_iam_role_policy_attachment" "node_AmazonEKS_CNI_Policy" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
   role       = "app-udacity-eks-node-role"
 }

  resource "aws_iam_role_policy_attachment" "node_AmazonEC2ContainerRegistryReadOnly" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
   role       = "app-udacity-eks-node-role"
 }

  resource "aws_iam_role_policy_attachment" "node_CloudWatchAgentServerPolicy" {
   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
   role       = "app-udacity-eks-node-role"
 }

  resource "aws_iam_role_policy_attachment" "node_harmony_policy_attachment" {
   policy_arn = var.instance_policy.arn
   role       = "app-udacity-eks-node-role"
 }