resource "aws_iam_role" "dockerhost" {
  name = "dockerhost"
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
  name = "jumphost"
  role = aws_iam_role.dockerhost.name
}

resource "aws_iam_role_policy" "dockerhost_policy" {
  name   = "dockerhost_policy"
  role   = aws_iam_role.dockerhost.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}