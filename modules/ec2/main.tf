data "aws_security_groups" "sgs" {
  tags = {
    Name = "allow_tls"
  }
}

data "aws_subnet" "publicsubnet" {
  tags = {
    Name = "test-public-subnet"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_groups.sgs.ids[0]]
  subnet_id              = data.aws_subnet.publicsubnet.id

  tags = {
    Name = "poc-test-ec2"
  }
}


 output "instanceid" {
    value = aws_instance.web.id
 }