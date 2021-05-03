variable "aws_profile" {
}

variable "namespace" {
  description = "AWS resource namespacing"
}

variable "aws_region" {
  type = string
}

variable "vpc_cidrs" {
  type = map(string)
}

variable "aws_availability_zones" {
  type = list(string)
}

variable "aws_availability_zone_count" {
  type = map(number)
}