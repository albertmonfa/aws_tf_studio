variable "nlb_arn" {
  type        = "string"
  description = "The ARN of the load balancer."
}

variable "nlb_tg_arn" {
  type        = "string"
  description = "The ARN of the Target Group to which to route traffic."
}

variable "port" {
  type        = "string"
  description = "The port on which the load balancer is listening."
  default     = 80
}
