# Definição do recurso do API Gateway
# STATUS
resource "aws_api_gateway_resource" "resource_status" {
  rest_api_id = aws_api_gateway_rest_api.bank_account_api.id
  parent_id   = aws_api_gateway_rest_api.bank_account_api.root_resource_id
  path_part   = "status"
}
# Definição do método GET do API Gateway
resource "aws_api_gateway_method" "status_method_get" {
  rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
  resource_id   = aws_api_gateway_resource.resource_status.id
  http_method   = "GET"
  authorization = "NONE"
}
# Integração entre o API Gateway e a função Lambda
resource "aws_api_gateway_integration" "lambda_integration_status" {
  rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
  resource_id             = aws_api_gateway_resource.resource_status.id
  http_method             = aws_api_gateway_method.status_method_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.extrato_account_lambda.invoke_arn
  # uri                     = aws_lambda_function.bank_account_lambda.invoke_arn
}