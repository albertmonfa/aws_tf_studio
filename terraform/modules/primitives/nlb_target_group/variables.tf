variable "project_name" {
  type        = "string"
  description = "The name of the project, usually will be the same of the endpoint. (Examples: zenith-commerce, wl-ssl-gateway, zenith-admin)"
}

variable "environment" {
  type        = "string"
  description = "The environment when the service will be deployed, The valid environments are: stg,sbx,prd or qa"
}

variable "vpc" {
  type        = "string"
  description = "The identifier of the VPC in which to create the target group."
}

variable "target_type" {
  type        = "string"
  description = "The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is instance. Note that you can't specify targets for a target group using both instance IDs and IP addresses. If the target type is ip, specify IP addresses from the subnets of the virtual private cloud (VPC) for the target group, the RFC 1918 range (10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16), and the RFC 6598 range (100.64.0.0/10). You can't specify publicly routable IP addresses."
  default = "instance"
}

variable "deregistration_delay" {
  type        = "string"
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  default     = 60
}

variable "port" {
  type        = "string"
  description = "The port on which targets receive traffic, unless overridden when registering a specific target."
  default     = 80
}

variable "protocol" {
  type        = "string"
  description = "The protocol to use for routing traffic to the targets."
  default     = "TCP"
}

variable "hc_interval" {
  type        = "string"
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds."
  default     = 10
}

variable "hc_healthy_threshold" {
  type        = "string"
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3."
  default     = 3
}

variable "hc_unhealthy_threshold" {
  type        = "string"
  description = "The number of consecutive health check failures required before considering the target unhealthy. Defaults to 3."
  default     = 3
}
