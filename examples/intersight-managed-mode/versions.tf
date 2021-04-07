# Terraform and Intersight Provider Information 
terraform {
  required_version = ">= 0.13.0"

  required_providers {
    intersight = {
      source  = "ciscodevnet/intersight"
      version = ">= 1.0.2"
    }
  }
}
