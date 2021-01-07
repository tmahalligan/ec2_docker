resource "aws_security_group" "docker_host" {
  name_prefix = "docker_host"
  vpc_id      = module.vpc.vpc_id


  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [format("%s/%s",data.external.whatismyip.result["internet_ip"],32)]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


