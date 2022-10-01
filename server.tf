# any device which has this ssh key pair can ssh into the instance below
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("./deployer.key")
}

resource "aws_instance" "web" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t4g.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.web_and_ssh.name]

  lifecycle {
    ignore_changes = [ami]
  }

  tags = {
    Name = "TerraformLearning"
  }

  root_block_device {
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true
  }
}

resource "aws_eip" "web" {
  instance = aws_instance.web.id
  vpc      = false
}
