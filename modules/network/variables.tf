#Variables from network
variable "vpc_cidr" {
  type        = string
  description = "CIDR Block VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR Block public subnet"
}
variable "private_subnet_cidr" {
  type        = string
  description = "CIDR Block private subnet"
}
