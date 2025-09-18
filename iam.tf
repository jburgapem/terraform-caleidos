resource "aws_iam_role" "fargate_primary" {
  name = "${var.cluster_name}-primary-fargate-pod-execution-role"
  assume_role_policy = data.aws_iam_policy_document.fargate_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "fargate_primary" {
  role       = aws_iam_role.fargate_primary.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

resource "aws_iam_role" "fargate_secondary" {
  name = "${var.cluster_name}-secondary-fargate-pod-execution-role"
  assume_role_policy = data.aws_iam_policy_document.fargate_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "fargate_secondary" {
  role       = aws_iam_role.fargate_secondary.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

data "aws_iam_policy_document" "fargate_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

pod_execution_role_arn = aws_iam_role.fargate_secondary.arn