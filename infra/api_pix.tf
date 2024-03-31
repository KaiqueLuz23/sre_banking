#####################################################
# Definição do recurso do API Gateway
# debito
resource "aws_api_gateway_resource" "resource_debito" {
  rest_api_id = aws_api_gateway_rest_api.bank_account_api.id
  parent_id   = aws_api_gateway_rest_api.bank_account_api.root_resource_id
  path_part   = "debito"
}
# Definição do método POST do API Gateway
resource "aws_api_gateway_method" "debito_method_post" {
  rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
  resource_id   = aws_api_gateway_resource.resource_debito.id
  http_method   = "POST"
  authorization = "NONE"
  
}
# Integração entre o API Gateway e a função Lambda
resource "aws_api_gateway_integration" "lambda_integration_debito" {
  rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
  resource_id             = aws_api_gateway_resource.resource_debito.id
  http_method             = aws_api_gateway_method.debito_method_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.pix_account_lambda.invoke_arn
}
#####################################################
# Definição do recurso do API Gateway
# transferir
resource "aws_api_gateway_resource" "resource_transferir" {
  rest_api_id = aws_api_gateway_rest_api.bank_account_api.id
  parent_id   = aws_api_gateway_rest_api.bank_account_api.root_resource_id
  path_part   = "transferir"
}
# Definição do método POST do API Gateway
resource "aws_api_gateway_method" "transferir_method_post" {
  rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
  resource_id   = aws_api_gateway_resource.resource_transferir.id
  http_method   = "POST"
  authorization = "NONE"
  
}
# Integração entre o API Gateway e a função Lambda
resource "aws_api_gateway_integration" "lambda_integration_transferir" {
  rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
  resource_id             = aws_api_gateway_resource.resource_transferir.id
  http_method             = aws_api_gateway_method.transferir_method_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.pix_account_lambda.invoke_arn
}