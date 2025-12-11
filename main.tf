module "network" {
  source              = "./modules/network"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "compute" {
  source            = "./modules/compute"
  vpc_id            = module.network.vpc_id
  public_subnet_id  = module.network.public_subnet_id
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  app_instance_name = var.app_instance_name
  s3_bucket_name    = var.s3_bucket_name
}

module "database" {
  source            = "./modules/database"
  vpc_id            = module.network.vpc_id
  private_subnet_id = module.network.private_subnet_id
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
}
