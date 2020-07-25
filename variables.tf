provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-1"
}

variable "host_zone_name" {
  type = string
}

variable "record_name" {
  type = string
}
