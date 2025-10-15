# KEY PAIR
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-6867"
  public_key = file("/home/ubuntu/terra/terraform.pub")
}

# DEFAULT VPC
resource "aws_default_vpc" "default" {

}

# SECURITY GROUP
resource "aws_security_group" "allow_user_connect" {
  name        = "allow-tls"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 INSTANCE
resource "aws_instance" "testinstance" {
  ami             = "ami-02d26659fd82cf299"
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_user_connect.name]

  tags = {
    Name = "Terra-Automated"
  }

}

