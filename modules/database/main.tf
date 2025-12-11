#Security Group
#SG für private-Subnet
resource "aws_security_group" "sg_db" {
  name        = "SG-DB"
  description = "Security Group für Datenbank im Private Subnet"
  vpc_id      = var.vpc_id

  tags = {
    Name = "SG-DB"
  }
}
resource "aws_vpc_security_group_egress_rule" "db_all_out" {
  security_group_id = aws_security_group.sg_db.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = [var.private_subnet_id]

  tags = {
    Name = "db-subnet-group"
  }
}
resource "aws_db_subnet_group" "db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.private.id]

  tags = {
    Name = "db-subnet-group"
  }
}
resource "aws_db_instance" "postgres" {
  identifier        = "my-postgres"
  engine            = "postgres"
  engine_version    = "15.3"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  username = var.db_username
  password = var.db_password
  db_name  = var.db_name

  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  publicly_accessible    = false
}
