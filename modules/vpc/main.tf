variable "vpc_cidr" {}
variable "vpc_name" {}
variable "public_subnets" {}

resource "aws_vpc" "poc-test-vpc" {
   cidr_block       = var.vpc_cidr
   instance_tenancy = "default"
   tags = {
    Name = var.vpc_name
   }
 }

 resource "aws_internet_gateway" "poc-test-igw" {    
    vpc_id =  aws_vpc.poc-test-vpc.id               
 }

 resource "aws_subnet" "poc-test-publicsubnet" { 
    vpc_id =  aws_vpc.poc-test-vpc.id
    cidr_block = "${var.public_subnets}"  
    tags = {
      Name = "test-public-subnet"
    }
 }

 output "vpcid" {
    value = aws_vpc.poc-test-vpc.id
 }