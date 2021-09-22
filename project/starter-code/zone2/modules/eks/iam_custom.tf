# resource "aws_iam_policy" "eks_cluster_role_cloudwatch_policy" {
#    name        = "app-${var.name}-eks-cluster-role-cloudwatch-policy"
#    description = "Policy allowing cloudwatch access to ${var.name} resources."
#    policy      = <<POLICY
# {
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#        "Effect": "Allow",
#        "Action": [
#          "cloudwatch:*",
#          "logs:DescribeLogGroups",
#          "logs:DescribeLogStreams",
#          "logs:CreateLogGroup",
#          "logs:CreateLogStream",
#          "logs:PutLogEvents"
#        ],
#        "Resource": "*"
#      }
#    ]
# }
# POLICY
# }

#  resource "aws_iam_policy" "eks_node_instance_policy" {
#    name        = "app-${var.name}-instance-policy"
#    description = "Policy allowing access to ${var.name} resources."

#    policy = <<EOF
# {
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#        "Effect": "Allow",
#        "Action": "s3:*",
#        "Resource": [
#            "arn:aws:s3:::*",
#            "arn:aws:s3:::*/*",
#            "arn:aws:s3:*:*:job/*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#            "logs:CreateLogGroup",
#            "logs:CreateLogStream",
#            "logs:PutLogEvents"
#        ],
#        "Resource": [
#            "arn:aws:logs:*:*:log-group:*",
#            "arn:aws:logs:*:*:log-group:*:*:*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#            "ecr:BatchCheckLayerAvailability",
#            "ecr:BatchGetImage",
#            "ecr:DescribeImages",
#            "ecr:DescribeRepositories",
#            "ecr:GetAuthorizationToken",
#            "ecr:GetDownloadUrlForLayer",
#            "ecr:GetRepositoryPolicy",
#            "ecr:ListImages"
#        ],
#        "Resource": "*"
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "sqs:ReceiveMessage",
#          "sqs:SendMessage",
#          "sqs:SendMessageBatch",
#          "sqs:DeleteMessage",
#          "sqs:DeleteMessageBatch",
#          "sqs:ChangeMessageVisibility",
#          "sqs:ChangeMessageVisibilityBatch"
#        ],
#        "Resource": [
#            "*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": "eks:DescribeCluster",
#        "Resource": "*"
#      }
#    ]
# }
#  EOF
#  }