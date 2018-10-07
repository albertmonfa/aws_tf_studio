provider "aws" {
  region     = "us-west-2"
}

module "foo-apps-ecs-nlb-sg-stg"   {
  source "../../../terraform/modules/primitives/sg/"

  sg_name = "foo_apps_ecs_nlb_sg_stg"
  sg_description = "Used to allow connections from the NLB to the ECS Cluster stg"
  vpc_id = "vpc-3"

  inbound_rules = {
    "0" = [ "0.0.0.0/0", "80", "80", "TCP" ]
    "1" = [ "0.0.0.0/0", "443", "443", "TCP" ]
    "2" = [ "10.0.0.0/8", "0", "0", "-1" ]
    "3" = [ "0.0.0.0/0", "32768", "65535", "TCP" ]
  }
  outbound_rules = {
    "0" = [ "0.0.0.0/0", "0", "0", "-1" ]
  }

}

module "foo-apps-iam-stg"   {
  source "../../../terraform/modules/modules/ecs-iam-roles/"

  prefix-name                 = "foo-apps-stg"
}

module "foo-apps-ecs-cluster-stg"   {
  source "../../../terraform/modules/modules/ecs-cluster/"

  ecs_cluster_name            = "foo-apps-cluster-stg"
  ecs_cluster_sns_topic_name  = "foo-apps-cluster-sns-stg"
  sns_lambda_iam_role         = "${module.foo-apps-iam-stg.role-sns-lambda}"
  lambda_iam_role             = "${module.foo-apps-iam-stg.role-ecs-lambda}"

  lc_name                     = "foo-apps-cluster-lc-stg"
  lc_ami                      = "ami-10ed6968"
  lc_instance_type            = "m4.2xlarge"
  lc_enable_monitoring        = true
  lc_security_groups          = ["${module.foo-apps-ecs-nlb-sg-stg.id}"]
  lc_key_name                 = "FOOKEY"
  lc_iam_instance_profile     = "${module.foo-apps-iam-stg.ecs-instance-profile}"

  asg_name                    = "foo-apps-cluster-asg-stg"
  asg_subnets                 = ["subnet-7","subnet-8","subnet-9"]
}
