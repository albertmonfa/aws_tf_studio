resource "aws_ecs_task_definition" "app_ecs_td" {
  family                              = "${var.project_name}"
  container_definitions               = "${file("${var.ecs_container_definitions}")}"
  task_role_arn                       = "${var.task_role_arn}"
}

resource "aws_ecs_service" "app_ecs_service" {
  name                                = "${var.project_name}-${var.environment}-service"
  cluster                             = "${var.ecs_cluster_name}"
  task_definition                     = "${aws_ecs_task_definition.app_ecs_td.arn}"

  desired_count                       = "${var.ecs_app_min_capacity}"
  deployment_minimum_healthy_percent  = "${var.ecs_app_deployment_minimum_healthy_percent}"
  deployment_maximum_percent          = "${var.ecs_app_deployment_maximum_percent}"

  placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  depends_on = ["aws_ecs_task_definition.app_ecs_td"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_cpu_high" {
  alarm_name                    = "${var.project_name}-${var.environment}-service-cpu-utilization-high"
  comparison_operator           = "${var.cloudwatch_metric_alarm_app_cpu_high_comparison_operator}"
  evaluation_periods            = "${var.cloudwatch_metric_alarm_app_cpu_high_evaluation_periods}"
  metric_name                   = "CPUUtilization"
  namespace                     = "AWS/ECS"
  period                        = "${var.cloudwatch_metric_alarm_app_cpu_high_period}"
  statistic                     = "${var.cloudwatch_metric_alarm_app_cpu_high_statistic}"
  threshold                     = "${var.cloudwatch_metric_alarm_app_cpu_high_threshold}"
  alarm_actions                 = ["${aws_appautoscaling_policy.cpu_app_scale_up.arn}"]

  dimensions {
    ClusterName                 = "${var.ecs_cluster_name}"
    ServiceName                 = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.cpu_app_scale_up"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_cpu_low" {
  alarm_name                    = "${var.project_name}-${var.environment}-service-cpu-utilization-low"
  comparison_operator           = "${var.cloudwatch_metric_alarm_app_cpu_low_comparison_operator}"
  evaluation_periods            = "${var.cloudwatch_metric_alarm_app_cpu_low_evaluation_periods}"
  metric_name                   = "CPUUtilization"
  namespace                     = "AWS/ECS"
  period                        = "${var.cloudwatch_metric_alarm_app_cpu_low_period}"
  statistic                     = "${var.cloudwatch_metric_alarm_app_cpu_low_statistic}"
  threshold                     = "${var.cloudwatch_metric_alarm_app_cpu_low_threshold}"
  alarm_actions                 = ["${aws_appautoscaling_policy.cpu_app_scale_down.arn}"]

  dimensions {
    ClusterName                 = "${var.ecs_cluster_name}"
    ServiceName                 = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.cpu_app_scale_down"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_memory_high" {
  alarm_name                      = "${var.project_name}-${var.environment}-service-memory-utilization-high"
  comparison_operator             = "${var.cloudwatch_metric_alarm_app_memory_high_comparison_operator}"
  evaluation_periods              = "${var.cloudwatch_metric_alarm_app_memory_high_evaluation_periods}"
  metric_name                     = "MemoryUtilization"
  namespace                       = "AWS/ECS"
  period                          = "${var.cloudwatch_metric_alarm_app_memory_high_period}"
  statistic                       = "${var.cloudwatch_metric_alarm_app_memory_high_statistic}"
  threshold                       = "${var.cloudwatch_metric_alarm_app_memory_high_threshold}"
  alarm_actions                   = ["${aws_appautoscaling_policy.mem_app_scale_up.arn}"]

  dimensions {
    ClusterName                   = "${var.ecs_cluster_name}"
    ServiceName                   = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.mem_app_scale_up"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_memory_low" {
  alarm_name                      = "${var.project_name}-${var.environment}-service-memory-utilization-low"
  comparison_operator             = "${var.cloudwatch_metric_alarm_app_memory_low_comparison_operator}"
  evaluation_periods              = "${var.cloudwatch_metric_alarm_app_memory_low_evaluation_periods}"
  metric_name                     = "MemoryUtilization"
  namespace                       = "AWS/ECS"
  period                          = "${var.cloudwatch_metric_alarm_app_memory_low_period}"
  statistic                       = "${var.cloudwatch_metric_alarm_app_memory_low_statistic}"
  threshold                       = "${var.cloudwatch_metric_alarm_app_memory_low_threshold}"
  alarm_actions                   = ["${aws_appautoscaling_policy.mem_app_scale_down.arn}"]

  dimensions {
    ClusterName                   = "${var.ecs_cluster_name}"
    ServiceName                   = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.mem_app_scale_down"]
}

resource "aws_appautoscaling_target" "app_target" {
  resource_id                     = "service/${var.ecs_cluster_name}/${var.project_name}-${var.environment}-service"
  role_arn                        = "${var.ecs_service_autoscale}"
  scalable_dimension              = "ecs:service:DesiredCount"
  min_capacity                    = "${var.ecs_app_min_capacity}"
  max_capacity                    = "${var.ecs_app_max_capacity}"
  service_namespace               = "ecs"

  depends_on = ["aws_ecs_service.app_ecs_service"]
}

resource "aws_appautoscaling_target" "app_target" {
  resource_id                     = "service/${var.ecs_cluster_name}/${var.project_name}-${var.environment}-service"
  role_arn                        = "${var.ecs_service_autoscale}"
  scalable_dimension              = "ecs:service:DesiredCount"
  min_capacity                    = "${var.ecs_app_min_capacity}"
  max_capacity                    = "${var.ecs_app_max_capacity}"
  service_namespace               = "ecs"

  depends_on = ["aws_ecs_service.app_ecs_service"]
}

resource "aws_appautoscaling_policy" "cpu_app_scale_up" {
  name                            = "${var.project_name}-${var.environment}-service-cpu-scale-up"
  resource_id                     = "service/${var.ecs_cluster_name}/${var.project_name}-${var.environment}-service"
  scalable_dimension              = "ecs:service:DesiredCount"
  service_namespace               = "ecs"

  step_scaling_policy_configuration {
    adjustment_type               = "${var.ecs_cpu_app_pol_scale_up_adjustment_type}"
    cooldown                      = "${var.ecs_cpu_app_pol_scale_up_cooldown}"
    metric_aggregation_type       = "${var.ecs_cpu_app_pol_scale_up_metric_aggregation_type}"

    step_adjustment {
      metric_interval_lower_bound = "${var.ecs_cpu_app_pol_scale_up_metric_interval_lower_bound}"
      scaling_adjustment          = "${var.ecs_cpu_app_pol_scale_up_scaling_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.app_target"]
}

resource "aws_appautoscaling_policy" "cpu_app_scale_down" {
  name                            = "${var.project_name}-${var.environment}-service-cpu-scale-down"
  resource_id                     = "service/${var.ecs_cluster_name}/${var.project_name}-${var.environment}-service"
  scalable_dimension              = "ecs:service:DesiredCount"
  service_namespace               = "ecs"

  step_scaling_policy_configuration {
    adjustment_type               = "${var.ecs_cpu_app_pol_scale_down_adjustment_type}"
    cooldown                      = "${var.ecs_cpu_app_pol_scale_down_cooldown}"
    metric_aggregation_type       = "${var.ecs_cpu_app_pol_scale_down_metric_aggregation_type}"

    step_adjustment {
      metric_interval_upper_bound = "${var.ecs_cpu_app_pol_scale_down_metric_interval_upper_bound}"
      scaling_adjustment          = "${var.ecs_cpu_app_pol_scale_down_scaling_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.app_target"]
}

resource "aws_appautoscaling_policy" "mem_app_scale_up" {
  name                            = "${var.project_name}-${var.environment}-service-mem-scale-up"
  resource_id                     = "service/${var.ecs_cluster_name}/${var.project_name}-${var.environment}-service"
  scalable_dimension              = "ecs:service:DesiredCount"
  service_namespace               = "ecs"

  step_scaling_policy_configuration {
    adjustment_type               = "${var.ecs_mem_app_pol_scale_up_adjustment_type}"
    cooldown                      = "${var.ecs_mem_app_pol_scale_up_cooldown}"
    metric_aggregation_type       = "${var.ecs_mem_app_pol_scale_up_metric_aggregation_type}"

    step_adjustment {
      metric_interval_lower_bound = "${var.ecs_mem_app_pol_scale_up_metric_interval_lower_bound}"
      scaling_adjustment          = "${var.ecs_mem_app_pol_scale_up_scaling_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.app_target"]
}

resource "aws_appautoscaling_policy" "mem_app_scale_down" {
  name                            = "${var.project_name}-${var.environment}-service-mem-scale-down"
  resource_id                     = "service/${var.ecs_cluster_name}/${var.project_name}-${var.environment}-service"
  scalable_dimension              = "ecs:service:DesiredCount"
  service_namespace               = "ecs"

  step_scaling_policy_configuration {
    adjustment_type               = "${var.ecs_mem_app_pol_scale_down_adjustment_type}"
    cooldown                      = "${var.ecs_mem_app_pol_scale_down_cooldown}"
    metric_aggregation_type       = "${var.ecs_mem_app_pol_scale_down_metric_aggregation_type}"

    step_adjustment {
      metric_interval_upper_bound = "${var.ecs_mem_app_pol_scale_down_metric_interval_upper_bound}"
      scaling_adjustment          = "${var.ecs_mem_app_pol_scale_down_scaling_adjustment}"
    }
  }

  depends_on = ["aws_appautoscaling_target.app_target"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_cpu_high" {
  alarm_name                    = "${var.project_name}-${var.environment}-service-cpu-utilization-high"
  comparison_operator           = "${var.cloudwatch_metric_alarm_app_cpu_high_comparison_operator}"
  evaluation_periods            = "${var.cloudwatch_metric_alarm_app_cpu_high_evaluation_periods}"
  metric_name                   = "CPUUtilization"
  namespace                     = "AWS/ECS"
  period                        = "${var.cloudwatch_metric_alarm_app_cpu_high_period}"
  statistic                     = "${var.cloudwatch_metric_alarm_app_cpu_high_statistic}"
  threshold                     = "${var.cloudwatch_metric_alarm_app_cpu_high_threshold}"
  alarm_actions                 = ["${aws_appautoscaling_policy.cpu_app_scale_up.arn}"]

  dimensions {
    ClusterName                 = "${var.ecs_cluster_name}"
    ServiceName                 = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.cpu_app_scale_up"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_cpu_low" {
  alarm_name                    = "${var.project_name}-${var.environment}-service-cpu-utilization-low"
  comparison_operator           = "${var.cloudwatch_metric_alarm_app_cpu_low_comparison_operator}"
  evaluation_periods            = "${var.cloudwatch_metric_alarm_app_cpu_low_evaluation_periods}"
  metric_name                   = "CPUUtilization"
  namespace                     = "AWS/ECS"
  period                        = "${var.cloudwatch_metric_alarm_app_cpu_low_period}"
  statistic                     = "${var.cloudwatch_metric_alarm_app_cpu_low_statistic}"
  threshold                     = "${var.cloudwatch_metric_alarm_app_cpu_low_threshold}"
  alarm_actions                 = ["${aws_appautoscaling_policy.cpu_app_scale_down.arn}"]

  dimensions {
    ClusterName                 = "${var.ecs_cluster_name}"
    ServiceName                 = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.cpu_app_scale_down"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_memory_high" {
  alarm_name                      = "${var.project_name}-${var.environment}-service-memory-utilization-high"
  comparison_operator             = "${var.cloudwatch_metric_alarm_app_memory_high_comparison_operator}"
  evaluation_periods              = "${var.cloudwatch_metric_alarm_app_memory_high_evaluation_periods}"
  metric_name                     = "MemoryUtilization"
  namespace                       = "AWS/ECS"
  period                          = "${var.cloudwatch_metric_alarm_app_memory_high_period}"
  statistic                       = "${var.cloudwatch_metric_alarm_app_memory_high_statistic}"
  threshold                       = "${var.cloudwatch_metric_alarm_app_memory_high_threshold}"
  alarm_actions                   = ["${aws_appautoscaling_policy.mem_app_scale_up.arn}"]

  dimensions {
    ClusterName                   = "${var.ecs_cluster_name}"
    ServiceName                   = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.mem_app_scale_up"]
}

resource "aws_cloudwatch_metric_alarm" "app_service_memory_low" {
  alarm_name                      = "${var.project_name}-${var.environment}-service-memory-utilization-low"
  comparison_operator             = "${var.cloudwatch_metric_alarm_app_memory_low_comparison_operator}"
  evaluation_periods              = "${var.cloudwatch_metric_alarm_app_memory_low_evaluation_periods}"
  metric_name                     = "MemoryUtilization"
  namespace                       = "AWS/ECS"
  period                          = "${var.cloudwatch_metric_alarm_app_memory_low_period}"
  statistic                       = "${var.cloudwatch_metric_alarm_app_memory_low_statistic}"
  threshold                       = "${var.cloudwatch_metric_alarm_app_memory_low_threshold}"
  alarm_actions                   = ["${aws_appautoscaling_policy.mem_app_scale_down.arn}"]

  dimensions {
    ClusterName                   = "${var.ecs_cluster_name}"
    ServiceName                   = "${var.project_name}-${var.environment}-service"
  }

  depends_on = ["aws_appautoscaling_policy.mem_app_scale_down"]
}
