terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "${var.aws_region}"
  profile = "rohit-poc"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name = var.vpc_name
  vpc_cidr =  var.vpc_cidr
  public_subnets = var.public_subnets
}

module "securitygroup" {
  source = "./modules/securitygroup"

  vpc_id = module.vpc.vpcid
}

module "ec2" {
  source = "./modules/ec2"
  depends_on = [module.vpc,module.securitygroup]
}

module "s3" {
  source = "./modules/s3"
  s3bucketname = var.s3bucketname
}