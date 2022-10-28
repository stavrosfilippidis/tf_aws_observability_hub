resource "aws_iam_policy" "allow_cloudwatch_metrics_access" {
    name = "${var.module_name}_allow_cloudwatch_metrics_access_${random_string.uid.result}"
    path = "/"
    description = "Grants access to logs cluster to fetch cloudwatch metrics for display."

    policy = jsonencode({

      "Version" : "2012-10-17",
      "Statement" : [
          {
            "Sid": "AllowReadingMetricsFromCloudWatch",
            "Effect": "Allow",
            "Action": [
              "cloudwatch:DescribeAlarmsForMetric",
              "cloudwatch:DescribeAlarmHistory",
              "cloudwatch:DescribeAlarms",
              "cloudwatch:ListMetrics",
              "cloudwatch:GetMetricStatistics",
              "cloudwatch:GetMetricData",
              "cloudwatch:GetInsightRuleReport"
            ],
            "Resource": "*"
          },
          {
            "Sid": "AllowReadingLogsFromCloudWatch",
            "Effect": "Allow",
            "Action": [
              "logs:DescribeLogGroups",
              "logs:GetLogGroupFields",
              "logs:StartQuery",
              "logs:StopQuery",
              "logs:GetQueryResults",
              "logs:GetLogEvents"
            ],
            "Resource": "*"
          },
          {
            "Sid": "AllowReadingTagsInstancesRegionsFromEC2",
            "Effect": "Allow",
            "Action": ["ec2:DescribeTags", "ec2:DescribeInstances", "ec2:DescribeRegions"],
            "Resource": "*"
          },
          {
            "Sid": "AllowReadingResourcesForTags",
            "Effect": "Allow",
            "Action": "tag:GetResources",
            "Resource": "*"
          }
        ]
  })
}

resource "aws_iam_role" "observability_hub" {
  name = "${var.module_name}_${random_string.uid.result}"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "observability_hub" {
  name = "${var.module_name}_${random_string.uid.result}"
  role = aws_iam_role.observability_hub.name
}
