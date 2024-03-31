#####################################################
# Definição do recurso do API Gateway
# extrato
resource "aws_api_gateway_resource" "resource_extrato" {
  rest_api_id = aws_api_gateway_rest_api.bank_account_api.id
  parent_id   = aws_api_gateway_rest_api.bank_account_api.root_resource_id
  path_part   = "extrato"
}
# Definição do método GET do API Gateway
resource "aws_api_gateway_method" "extrato_method_get" {
  rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
  resource_id   = aws_api_gateway_resource.resource_extrato.id
  http_method   = "GET"
  authorization = "NONE"
}
# Integração entre o API Gateway e a função Lambda
resource "aws_api_gateway_integration" "lambda_integration_extrato" {
  rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
  resource_id             = aws_api_gateway_resource.resource_extrato.id
  http_method             = aws_api_gateway_method.extrato_method_get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.extrato_account_lambda.invoke_arn
}
