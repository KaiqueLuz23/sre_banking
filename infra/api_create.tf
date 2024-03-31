# Definição do recurso do API Gateway
# create
resource "aws_api_gateway_resource" "resource_create" {
  rest_api_id = aws_api_gateway_rest_api.bank_account_api.id
  parent_id   = aws_api_gateway_rest_api.bank_account_api.root_resource_id
  path_part   = "create"
}
# Definição do método PUT do API Gateway para atualização
resource "aws_api_gateway_method" "update_method_put" {
  rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
  resource_id   = aws_api_gateway_resource.resource_create.id
  http_method   = "PUT"
  authorization = "NONE"
}

# Atualização da integração entre o API Gateway e a função Lambda
resource "aws_api_gateway_integration" "lambda_integration_update_put" {
  rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
  resource_id             = aws_api_gateway_resource.resource_create.id
  http_method             = aws_api_gateway_method.update_method_put.http_method
  integration_http_method = "PUT"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.bank_account_lambda.invoke_arn
}

# GET

# # Definição do método GET do API Gateway
# resource "aws_api_gateway_method" "create_method_get" {
#   rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
#   resource_id   = aws_api_gateway_resource.resource_create.id
#   http_method   = "GET"
#   authorization = "NONE"
# }
# # Integração entre o API Gateway e a função Lambda
# resource "aws_api_gateway_integration" "lambda_integration_create_get" {
#   rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
#   resource_id             = aws_api_gateway_resource.resource_create.id
#   http_method             = aws_api_gateway_method.create_method_get.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = aws_lambda_function.bank_account_lambda.invoke_arn
# }
#####################################################
# POST
# Definição do método GET do API Gateway
resource "aws_api_gateway_method" "create_method_post" {
  rest_api_id   = aws_api_gateway_rest_api.bank_account_api.id
  resource_id   = aws_api_gateway_resource.resource_create.id
  http_method   = "POST"
  authorization = "NONE"
}
# Integração entre o API Gateway e a função Lambda
resource "aws_api_gateway_integration" "lambda_integration_create_post" {
  rest_api_id             = aws_api_gateway_rest_api.bank_account_api.id
  resource_id             = aws_api_gateway_resource.resource_create.id
  http_method             = aws_api_gateway_method.create_method_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.bank_account_lambda.invoke_arn
}
