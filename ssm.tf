data "aws_iam_policy_document" "ssm" {
  source_json = data.aws_iam_policy.ssm.policy

  statement {
    effect = "Allow"
    resources = ["*"]

    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "kms:Decrypt"
    ]
  }
}

data "aws_iam_policy" "ssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_cloudwatch_log_group" "operation" {
  name = "minecraft_operation"
  retention_in_days = 30
}

resource "aws_s3_bucket" "operation" {
  bucket = "minecraft-operation-log-${random_integer.operation.result}"

  lifecycle_rule {
    enabled = true

    expiration {
      days = "30"
    }
  }
}

resource "random_integer" "operation" {
  min     = 1
  max     = 99999
}

resource "aws_ssm_document" "session_managete_run_shell" {
  name = "SSM-SessionManagerRunShell"
  document_type = "Session"
  document_format = "JSON"

  content = <<EOF
  {
    "schemaVersion": "1.0",
    "description": "ssm session manager run shell",
    "sessionType": "Standard_Stream",
    "inputs": {
      "s3BucketName": "${aws_s3_bucket.operation.id}",
      "cloudWatchLogGroupName": "${aws_cloudwatch_log_group.operation.name}"
    }
  }
  EOF
}
