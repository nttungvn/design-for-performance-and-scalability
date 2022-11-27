provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "lambda_role" {
  name = "udacity_lambda_role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Principal": {
        "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
    }
    ]
  }
  EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  path        = "/"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
        ],
        "Resource": "arn:aws:logs:*:*:*",
        "Effect": "Allow"
      },
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": [
          "arn:aws:logs:*:*:log-group:/aws/lambda/udacity-lambda:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachment_role" {
    role = aws_iam_role.lambda_role.name
    policy_arn = aws_iam_policy.lambda_policy.arn
}

data "archive_file" "python_code" {
    type = "zip"
    source_file = "${path.module}/greet_lambda.py"
    output_path = "${path.module}/greet_lambda.zip"
}

resource "aws_lambda_function" "lambda_function" {
    filename = "${path.module}/greet_lambda.zip"
    function_name = var.lambda_name
    role = aws_iam_role.lambda_role.arn
    handler = "greet_lambda.${var.lambda_handler}"
    runtime = var.lambda_runtime
    depends_on = [
      aws_iam_role_policy_attachment.attachment_role
    ]
    environment {
      variables = {
        greeting = "Hello TungNT!"
      }
    }
}