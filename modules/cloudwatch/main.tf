resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "high_cpu_utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  alarm_description   = "This metric monitors ec2 cpu utilization"
  dimensions = {
    InstanceId = var.instance_id
  }

  actions_enabled     = true
  alarm_actions       = [var.sns_topic_arn]
}
