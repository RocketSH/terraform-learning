# any device which has this ssh key pair can ssh into the instance below
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("./deployer.key")
}

resource "aws_instance" "web" {
  ami           = "ami-05d8c3dc27d413c4b"
  instance_type = "t4g.micro"
  key_name      = aws_key_pair.deployer.key_name

  tags = {
    Name = "TerraformLearning"
  }

  root_block_device {
    volume_size           = 8
    delete_on_termination = true
    encrypted             = true
  }
}
