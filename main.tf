

module "network" {
  source = "./modules/network"

  vpc_cidr              = var.vpc_cidr
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
}

module "security_groups" {
  source = "./modules/security_groups"

  vpc_id = module.network.vpc_id
  rds_security_group_id = module.security_groups.rds_sg.id
}

module "ec2" {
  source = "./modules/ec2"

  public_subnet_id = module.network.public_subnet_a_id
  private_subnet_id = module.network.private_subnet_a_id
  bastion_sg_id    = module.security_groups.bastion_sg_id
  private_sg_id    = module.security_groups.private_sg_id
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  instance_id   = module.ec2.private_id
  sns_topic_arn = module.sns.topic_arn
}

module "sns" {
  source   = "./modules/sns"

  email    =  var.email
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}

module "rds" {
  source = "./modules/rds"

  db_name            = var.db_name
  username           = var.db_username
  password           = var.db_password
  subnet_ids         = [module.network.private_subnet_a_id, module.network.private_subnet_b_id]
  vpc_id             = module.network.vpc_id
  private_sg_id       = module.security_groups.private_sg.id
}

module "lambda" {
  source = "./modules/lambda"
  bucket_arn  = module.s3.bucket_arn
  filename              = "lambda-function.py"
  function_name         = "my_lambda_function"
  role_arn              = "arn:aws:iam::123456789012:role/execution_role"
  handler               = "lambda_function.lambda_handler"
  runtime               = "python3.8"
  environment_variables = {
    key = "value"
  }
  bucket_name           =  var.bucket_name

}

module "alb" {
  source = "./modules/alb"

  vpc_id             = module.network.vpc_id
  alb_sg_id          = module.security_groups.alb_sg.id
  public_subnet_a_id = module.network.public_subnet_a_id
  public_subnet_b_id = module.network.public_subnet_b_id
  private_instance_id = module.ec2.private_instance.id
}
