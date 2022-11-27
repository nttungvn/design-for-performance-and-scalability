# TODO: Define the output variable for the lambda function.
output "arn" {
    value = aws_lambda_function.lambda_function.arn
}