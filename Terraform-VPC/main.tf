terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
  }
}

locals {
  AWS_REGION_DC = "us-east-1"
  AWS_REGION_DR = "us-east-2"
}

provider "aws" {
  region = local.AWS_REGION_DC
}

provider "aws" {
  region = local.AWS_REGION_DR
  alias = "dr"
}

resource "aws_vpc" "main_dc" {
    cidr_block = "192.168.10.0/24"
}

resource "aws_vpc" "main_dr" {
    cidr_block = "172.32.0.0/16"
    provider = aws.dr
}

