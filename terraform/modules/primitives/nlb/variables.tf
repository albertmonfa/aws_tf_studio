variable "project_name" {
  type        = "string"
  description = "The name of the project, usually will be the same of the endpoint. (Examples: zenith-commerce, wl-ssl-gateway, zenith-admin)"
}

variable "environment" {
  type        = "string"
  description = "The environment when the service will be deployed, The valid environments are: stg,sbx,prd or qa"
}

variable "subnets" {
  type        = "list"
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value will for load balancers of type network will force a recreation of the resource."
}

variable "internal" {
  type        = "string"
  description = "If true, the LB will be internal. Default true"
  default     = true
}

variable "enable_deletion_protection" {
  type        = "string"
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  default     = false
}

variable "idle_timeout" {
  type        = "string"
  description = "The time in seconds that the connection is allowed to be idle. Default: 20."
  default     = 20
}
