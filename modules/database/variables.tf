variable "vpc_id" {
  type        = string
  description = "VPC ID DB Security Group"
}

variable "private_subnet_id" {
  type        = string
  description = "Subnet ID DB Subnet Group"
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type        = string
  description = "DB Benutzername"
}

variable "db_password" {
  type        = string
  description = "DB Password"
}
