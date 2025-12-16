variable "instance_type" {
  type        = string
  description = "EC2 Instance-Typ"
  default     = "t2.micro"
}

variable "app_instance_name" {
  type        = string
  description = "Name-Tag der EC2-Instanz"
  default     = "HelloWorld"
}

variable "ami_id" {
  type        = string
  description = "AMI ID für EC2"
  default     = "ami-123456789"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name des S3 Buckets"
  default     = "anfang-terraform-bucket"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type    = string
  default = "admin"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}
