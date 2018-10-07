module "ecs-wl-ssl-gateway-service-prd"   {
  source "../../../terraform/modules/modules/ecs-service-nlb/"

  project_name                = "ecs-wl-ssl-gateway"
  environment                 = "prd"

  ecs_cluster_name            = "foo-apps-cluster-prd"
  ecs_service_role            = "arn:aws:iam::AWSCLIENTID:role/foo-apps-stg-ecs-role-service"
  ecs_service_autoscale       = "arn:aws:iam::AWSCLIENTID:role/foo-apps-stg-ecs-service-autoscale"
  task_role_arn               = "arn:aws:iam::AWSCLIENTID:role/ECS_Service_SSLCerts_RO"
  ecs_container_definitions   = "app-task-definition-hello-world.json"
  ecs_container_name          = "lb_container"
  ecs_container_port          = 443

  ecs_app_min_capacity        = 6
  ecs_app_max_capacity        = 40

  nlb_subnets                 = ["subnet-1","subnet-2","subnet-3"]
  nlb_internal                = false
  tg_vpc                      = "vpc-1"
  tg_port                     = 443
  nlb_listeners               = [ 80, 443 ]
}
