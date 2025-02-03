module "project_rds_s" {
  source                  = "./modules/rds-s"
  primary_db_cluster_arn  = data.terraform_remote_state.primary.outputs.db_cluster_id
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
}