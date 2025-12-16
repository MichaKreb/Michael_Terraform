#Security Group EC2
resource "aws_security_group" "ec2_sg" {
  name        = "SG1"
  description = "Security Group EC2 in Public Subnet"
  vpc_id      = var.vpc_id
  tags = {
    Name = "SG1"
  }
}
resource "aws_vpc_security_group_egress_rule" "all_out" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # -1 = all allowed
}
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  cidr_ipv4         = "0.0.0.0/0" #or own ip
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}
#S3 Bucket
resource "aws_s3_bucket" "storage" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Storage"
    Environment = "Dev"
  }
}
#IAM Role, accepted by EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}
#IAM Policy, applied to S3-Bucket
resource "aws_iam_policy" "s3_access" {
  name = "ec2-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:ListBucket",
        "s3:GetObject",
        "s3:PutObject"
      ]
      Resource = [
        aws_s3_bucket.storage.arn,
        "${aws_s3_bucket.storage.arn}/*"
      ]
    }]
  })
}
#Connect: Policy to Role
resource "aws_iam_role_policy_attachment" "ec2_s3_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access.arn
}

#Instance Profile used by ec2 util Role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-s3-profile"
  role = aws_iam_role.ec2_role.name
}
#EC2 Instance
resource "aws_instance" "example" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = var.app_instance_name
  }
}
