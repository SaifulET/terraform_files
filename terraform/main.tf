module "vpc" {

  source = "./modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr

}


module "security_groups" {

  source = "./modules/security-groups"

  project_name            = var.project_name
  vpc_id                  = module.vpc.vpc_id
  admin_cidr_blocks       = var.admin_cidr_blocks
  app_ingress_cidr_blocks = var.app_ingress_cidr_blocks

}

module "bastion" {

  source = "./modules/bastion"

  project_name = var.project_name

  subnet_id = module.vpc.public_subnet_1_id

  security_group_id = module.security_groups.bastion_sg_id

  key_name = var.key_name

  instance_type = var.instance_type

}

module "app_server" {

  source = "./modules/app-server"

  project_name = var.project_name

  subnet_id = module.vpc.private_subnet_1_id

  security_group_id = module.security_groups.app_sg_id

  key_name = var.key_name

  instance_type = var.instance_type
  user_data     = file("${path.root}/../scripts/app-userdata.sh")

}

module "alb" {

  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  security_group_id = module.security_groups.alb_sg_id
  target_id         = module.app_server.instance_id

}

module "monitoring_server" {

  source = "./modules/monitoring-server"

  project_name = var.project_name

  subnet_id = module.vpc.public_subnet_2_id

  security_group_id = module.security_groups.monitoring_sg_id

  key_name = var.key_name

  instance_type = var.monitoring_instance_type

}

module "rds" {

  source = "./modules/rds"

  db_username = var.db_username

  db_password = var.db_password

  subnet_1 = module.vpc.private_subnet_1_id

  subnet_2 = module.vpc.private_subnet_2_id

  security_group_id = module.security_groups.rds_sg_id

}
