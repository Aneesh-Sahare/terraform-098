#KEY
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-6867"
  public_key = file("/home/ubuntu/terra")
}

#VPC
resource "aws_default_vpc" "default" {

}

#SG
resource "aws_security_group" "allow_user_connect" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id
  
  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = " allow all outgoing traffic "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

#EC2
resource "aws_instance" "testinstance" {
  ami             = data.aws_ami.os_image.id
  instance_type   = "t2.micro"  
  key_name        = aws_key_pair.deployer.key_name                         #interpolation
  security_groups = [aws_security_group.allow_user_to_connect.name]
  tags = {
    Name = "Terra-Automated"
  }
 

#COMMANDS
 provisioner "remote-exec" {
    inline = [
      "sudo apt update -y" 
    ]
  }
