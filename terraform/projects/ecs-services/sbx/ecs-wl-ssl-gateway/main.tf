module "ecs-wl-ssl-gateway-service-sbx"   {
  source "../../../terraform/modules/modules/ecs-service-nlb/"

  project_name                = "ecs-wl-ssl-gateway"
  environment                 = "sbx"

  ecs_cluster_name            = "foo-apps-cluster-sbx"
  ecs_service_role            = "arn:aws:iam::AWSCLIENTID:role/foo-apps-stg-ecs-role-service"
  ecs_service_autoscale       = "arn:aws:iam::AWSCLIENTID:role/foo-apps-stg-ecs-service-autoscale"
  task_role_arn               = "arn:aws:iam::AWSCLIENTID:role/ECS_Service_SSLCerts_RO"
  ecs_container_definitions   = "app-task-definition-hello-world.json"
  ecs_container_name          = "lb_container"
  ecs_container_port          = 443

  ecs_app_min_capacity        = 6
  ecs_app_max_capacity        = 40

  nlb_subnets                 = ["subnet-4","subnet-5","subnet-6"]
  nlb_internal                = false
  tg_vpc                      = "vpc-2"
  tg_port                     = 443
  nlb_listeners               = [ 80, 443 ]
}
