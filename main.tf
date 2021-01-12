# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

resource "random_string" "random" {
  length = 4
  special = false
  upper  = false
}

resource "aws_key_pair" "key" {
  key_name   = "${var.deployname}.${random_string.random.result}"
  public_key = file("~/.ssh/${var.owner}.pub")
}


resource "aws_instance" "docker_host" {
  ami                    = data.aws_ami.ubuntu_linux.id
  instance_type          = var.amitype
  vpc_security_group_ids = [aws_security_group.docker_host.id]
  iam_instance_profile   = aws_iam_instance_profile.dockerhost_profile.name
  key_name               = aws_key_pair.key.key_name
  private_ip             = "10.152.2.50"
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("files/dockerhost.sh")
  tags = {
    Name = "${var.deployname}.${random_string.random.result}"
    Owner = format("%s",data.external.whoiamuser.result.iam_user)
  }

  root_block_device {
    volume_size = var.volsize
    encrypted   = true
  }
  
    connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/tommy.pem")
    host        = self.public_ip
  }

}



resource "aws_eip" "ip_docker" {
  vpc      = true
  instance = aws_instance.docker_host.id 
}

resource "aws_s3_bucket" "dockerhostbucket" {
  bucket = "${var.deployname}.${random_string.random.result}"
  acl    = "private"

  tags = {
    Owner = format("%s",data.external.whoiamuser.result.iam_user)
  }
}