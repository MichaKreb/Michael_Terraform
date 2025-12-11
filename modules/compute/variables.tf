#Compute variables
variable "vpc_id" {
  type        = string
  description = "VPC ID Security Group"
}
variable "public_subnet_id" {
  type        = string
  description = "Subnet ID EC2-Instance"
}

variable "ami_id" {
  type        = string
  description = "AMI ID für die EC2-Instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance-Typ"
}

variable "app_instance_name" {
  type        = string
  description = "Name EC2-Instance"
}

variable "s3_bucket_name" {
  type        = string
  description = "Storage-Name"
}
