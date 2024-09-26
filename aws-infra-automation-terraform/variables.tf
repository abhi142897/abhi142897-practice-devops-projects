variable "region" {
  description = "The AWS region to create the resources in"
  type        = string
}

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "A map of subnets with CIDR blocks and availability zones"
  type        = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "instances" {
  description = "A map of instances"
  type        = map(object({
    ami            = string
    instance_type  = string
    user_data      = string
    subnet_key    = string 
  }))
}