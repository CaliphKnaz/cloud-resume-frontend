terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  required_version = ">= 1.1.0"

  cloud {
    organization = "Knaz"

    workspaces {
      name = "Cloud-resume-frontend"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


module "cloud-resume" {
  source      = "./modules/cloud-resume"
  bucket-name = "cloud-resume-999"

}

