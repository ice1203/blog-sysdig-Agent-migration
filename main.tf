provider "aws" {
  region = var.region
}

module "fargate-orchestrator-agent" {
  source  = "sysdiglabs/fargate-orchestrator-agent/aws"
  version = "0.4.1"

  vpc_id           = var.vpc_id
  subnets          = [var.subnet_a_id, var.subnet_b_id]

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

terraform {
  required_providers {
    sysdig = {
      source = "sysdiglabs/sysdig"
      version = ">= 0.5.39"
    }
  }
}

provider "sysdig" {
  sysdig_secure_api_token = var.secure_api_token
}