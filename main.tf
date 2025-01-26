locals {
  prefix = "sysdigagt-migration"
}

module "main_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "${local.prefix}-vpc"
  cidr = "172.18.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnets = ["172.18.0.0/24", "172.18.1.0/24", "172.18.2.0/24"]
  public_subnets  = ["172.18.128.0/24", "172.18.129.0/24", "172.18.130.0/24"]
  intra_subnets   = ["172.18.131.0/24", "172.18.132.0/24", "172.18.133.0/24"]

  enable_nat_gateway                   = true
  single_nat_gateway                   = false
  enable_vpn_gateway                   = false
  enable_dns_hostnames                 = true
  manage_default_network_acl           = true
  enable_flow_log                      = false
  flow_log_max_aggregation_interval    = 60
  create_flow_log_cloudwatch_iam_role  = true
  create_flow_log_cloudwatch_log_group = true
  public_dedicated_network_acl         = true

}

module "fargate-orchestrator-agent" {
  source  = "sysdiglabs/fargate-orchestrator-agent/aws"
  version = "0.4.1"

  vpc_id           = module.main_vpc.vpc_id
  subnets          = module.main_vpc.public_subnets

  access_key       = var.access_key

  collector_host   = var.collector_url
  collector_port   = 6443

  name             = "sysdig-orchestrator"
  agent_image      = "quay.io/sysdig/orchestrator-agent:latest"

  # True if the VPC uses an InternetGateway, false otherwise
  assign_public_ip = true

  tags = {
    description    = "Sysdig Serverless Agent Orchestrator"
    GuardDutyManaged = "false"
  }
}

