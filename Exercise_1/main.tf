# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  region = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity-t2" {
  ami = "ami-0b0dcb5067f052a63"
  count = 4
  instance_type = "t2.micro"
  subnet_id = "subnet-0de70dc97f073c16d"
  tags = {
    Name = "Udacity-T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity-t4" {
  ami = "ami-0b0dcb5067f052a63"
  count = 2
  instance_type = "m4.large"
  subnet_id = "subnet-0de70dc97f073c16d"
  tags = {
    Name = "Udacity-M4"
  }
}