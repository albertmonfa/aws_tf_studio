provider "aws" {
  region     = "us-west-2"
  version = "~> 1.7.1"
}

variable "project_name" {
  description = "Main name of the project"
}

variable "environment" {
  description = "Environment to deploy (Remember to checking the nlb_subnets and nlb_vpc variables)"
}

variable "task_role_arn" {
  type        = "string"
  description = "The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services."
}

variable "ecs_container_definitions" {
  description = "The Task Definition skeleton, after define the container names you can't change the names defined, please contact with IT/OPS for best practices and common container names"
}

variable "ecs_container_name" {
  description = "The Name of the container in the ECS Task Definition (Default zin_default)"
  default     = "zin_default"
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
}

variable "ecs_app_min_capacity" {
  description = "Minimum number of containers to run. (Default 3)"
  default = 3
}

variable "ecs_app_max_capacity" {
  description = "Maximum number of containers to run. (Default 10)"
  default = 10
}

variable "ecs_app_deployment_minimum_healthy_percent" {
  description = "The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. (Default 33)"
  default = 33
}

variable "ecs_app_deployment_maximum_percent" {
  description = "The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. (Default 200)"
  default = 200
}

variable "ecs_service_autoscale" {
  description = "The IAM role used to autoscale the number of containers based on CW metrics"
}

variable "ecs_cpu_app_pol_scale_up_adjustment_type" {
  type        = "string"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. (Default ChangeInCapacity)"
  default     = "ChangeInCapacity"
}

variable "ecs_cpu_app_pol_scale_up_cooldown" {
  type        = "string"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start. (Default 120)"
  default     = 30
}

variable "ecs_cpu_app_pol_scale_up_metric_aggregation_type" {
  type        = "string"
  description = "The aggregation type for the policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'. Without a value, AWS will treat the aggregation type as 'Average'. (Default Average)"
  default     = "Average"
}

variable "ecs_cpu_app_pol_scale_up_metric_interval_lower_bound" {
  type        = "string"
  description = "The lower bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound. (Default 0)"
  default     = 0
}

variable "ecs_cpu_app_pol_scale_up_scaling_adjustment" {
  type        = "string"
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down. (Default 1)"
  default     = 1
}

variable "ecs_cpu_app_pol_scale_down_adjustment_type" {
  type        = "string"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. (Default ChangeInCapacity)"
  default     = "ChangeInCapacity"
}

variable "ecs_cpu_app_pol_scale_down_cooldown" {
  type        = "string"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start. (Default 120)"
  default     = 30
}

variable "ecs_cpu_app_pol_scale_down_metric_aggregation_type" {
  type        = "string"
  description = "The aggregation type for the policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'. Without a value, AWS will treat the aggregation type as 'Average'. (Default Average)"
  default     = "Average"
}

variable "ecs_cpu_app_pol_scale_down_metric_interval_upper_bound" {
  type        = "string"
  description = "The upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound. (Default 0)"
  default     = 0
}

variable "ecs_cpu_app_pol_scale_down_scaling_adjustment" {
  type        = "string"
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down. (Default 1)"
  default     = -1
}

variable "ecs_mem_app_pol_scale_up_adjustment_type" {
  type        = "string"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. (Default ChangeInCapacity)"
  default     = "ChangeInCapacity"
}

variable "ecs_mem_app_pol_scale_up_cooldown" {
  type        = "string"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start. (Default 120)"
  default     = 30
}

variable "ecs_mem_app_pol_scale_up_metric_aggregation_type" {
  type        = "string"
  description = "The aggregation type for the policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'. Without a value, AWS will treat the aggregation type as 'Average'. (Default Average)"
  default     = "Average"
}

variable "ecs_mem_app_pol_scale_up_metric_interval_lower_bound" {
  type        = "string"
  description = "The lower bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound. (Default 0)"
  default     = 0
}

variable "ecs_mem_app_pol_scale_up_scaling_adjustment" {
  type        = "string"
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down. (Default 1)"
  default     = 1
}

variable "ecs_mem_app_pol_scale_down_adjustment_type" {
  type        = "string"
  description = "Specifies whether the adjustment is an absolute number or a percentage of the current capacity. Valid values are ChangeInCapacity, ExactCapacity, and PercentChangeInCapacity. (Default ChangeInCapacity)"
  default     = "ChangeInCapacity"
}

variable "ecs_mem_app_pol_scale_down_cooldown" {
  type        = "string"
  description = "The amount of time, in seconds, after a scaling activity completes and before the next scaling activity can start. (Default 120)"
  default     = 30
}

variable "ecs_mem_app_pol_scale_down_metric_aggregation_type" {
  type        = "string"
  description = "The aggregation type for the policy's metrics. Valid values are 'Minimum', 'Maximum', and 'Average'. Without a value, AWS will treat the aggregation type as 'Average'. (Default Average)"
  default     = "Average"
}

variable "ecs_mem_app_pol_scale_down_metric_interval_upper_bound" {
  type        = "string"
  description = "The upper bound for the difference between the alarm threshold and the CloudWatch metric. Without a value, AWS will treat this bound as infinity. The upper bound must be greater than the lower bound. (Default 0)"
  default     = 0
}

variable "ecs_mem_app_pol_scale_down_scaling_adjustment" {
  type        = "string"
  description = "The number of members by which to scale, when the adjustment bounds are breached. A positive value scales up. A negative value scales down. (Default 1)"
  default     = -1
}

variable "cloudwatch_metric_alarm_app_cpu_high_comparison_operator" {
  type        = "string"
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "cloudwatch_metric_alarm_app_cpu_high_evaluation_periods" {
  type        = "string"
  description = "The number of periods over which data is compared to the specified threshold."
  default     = "1"
}

variable "cloudwatch_metric_alarm_app_cpu_high_period" {
  type        = "string"
  description = "The period in seconds over which the specified statistic is applied."
  default     = "60"
}

variable "cloudwatch_metric_alarm_app_cpu_high_statistic" {
  type        = "string"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "cloudwatch_metric_alarm_app_cpu_high_threshold" {
  type        = "string"
  description = "The value against which the specified statistic is compared."
  default     = "70"
}

variable "cloudwatch_metric_alarm_app_cpu_low_comparison_operator" {
  type        = "string"
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  default     = "LessThanThreshold"
}

variable "cloudwatch_metric_alarm_app_cpu_low_evaluation_periods" {
  type        = "string"
  description = "The number of periods over which data is compared to the specified threshold."
  default     = "1"
}

variable "cloudwatch_metric_alarm_app_cpu_low_period" {
  type        = "string"
  description = "The period in seconds over which the specified statistic is applied."
  default     = "60"
}

variable "cloudwatch_metric_alarm_app_cpu_low_statistic" {
  type        = "string"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "cloudwatch_metric_alarm_app_cpu_low_threshold" {
  type        = "string"
  description = "The value against which the specified statistic is compared"
  default     = "20"
}

variable "cloudwatch_metric_alarm_app_memory_high_comparison_operator" {
  type        = "string"
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  default     = "GreaterThanOrEqualToThreshold"
}

variable "cloudwatch_metric_alarm_app_memory_high_evaluation_periods" {
  type        = "string"
  description = "The number of periods over which data is compared to the specified threshold."
  default     = "1"
}

variable "cloudwatch_metric_alarm_app_memory_high_period" {
  type        = "string"
  description = "The period in seconds over which the specified statistic is applied."
  default     = "60"
}

variable "cloudwatch_metric_alarm_app_memory_high_statistic" {
  type        = "string"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "cloudwatch_metric_alarm_app_memory_high_threshold" {
  type        = "string"
  description = "The value against which the specified statistic is compared"
  default     = "75"
}

variable "cloudwatch_metric_alarm_app_memory_low_comparison_operator" {
  type        = "string"
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold."
  default     = "LessThanThreshold"
}

variable "cloudwatch_metric_alarm_app_memory_low_evaluation_periods" {
  type        = "string"
  description = "The number of periods over which data is compared to the specified threshold."
  default     = "1"
}

variable "cloudwatch_metric_alarm_app_memory_low_period" {
  type        = "string"
  description = "The period in seconds over which the specified statistic is applied."
  default     = "60"
}

variable "cloudwatch_metric_alarm_app_memory_low_statistic" {
  type        = "string"
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
  default     = "Average"
}

variable "cloudwatch_metric_alarm_app_memory_low_threshold" {
  type        = "string"
  description = "The value against which the specified statistic is compared"
  default     = "35"
}
