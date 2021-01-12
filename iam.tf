resource "aws_iam_role" "dockerhost" {
  name_prefix = var.deployname
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


resource "aws_iam_instance_profile" "dockerhost_profile" {
  name_prefix = var.deployname
  role = aws_iam_role.dockerhost.name
}

resource "aws_iam_role_policy" "dockerhost_policy" {
  name_prefix   = var.deployname
  role   = aws_iam_role.dockerhost.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*",
        "imagebuilder:GetComponent",
        "imagebuilder:GetContainerRecipe",
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:PutImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}