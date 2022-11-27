# TODO: Define the variable for aws_region
variable "aws_region" {
  default = "us-east-1"
}

variable "lambda_runtime" {
  default = "python3.8"
}

variable "lambda_handler" {
  default = "lambda_handler"
}

variable "lambda_name" {
  default = "udacity-lambda"
}