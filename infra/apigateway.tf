# Definição do REST API do API Gateway
resource "aws_api_gateway_rest_api" "bank_account_api" {
  name                   = "bank-account-api"
  endpoint_configuration {
    types = ["REGIONAL"]  # Define o endpoint como regional
  }
  tags = {
    Name = "bank_account_api"
    Project =  "SRE_BANK"
  }
}
#####################################################
# Implantação do API Gateway
resource "aws_api_gateway_deployment" "bank_account_api" {
  depends_on = [
    #status
    aws_api_gateway_integration.lambda_integration_status,
    aws_api_gateway_method.status_method_get,
    #extrato
    aws_api_gateway_integration.lambda_integration_extrato,
    aws_api_gateway_method.extrato_method_get,
    #create
    # aws_api_gateway_integration.lambda_integration_create_get,
    # aws_api_gateway_method.create_method_get,
    aws_api_gateway_integration.lambda_integration_update_put,
    aws_api_gateway_method.update_method_put,
    aws_api_gateway_integration.lambda_integration_create_post,
    aws_api_gateway_method.create_method_post,
    #pix
    aws_api_gateway_integration.lambda_integration_debito,
    aws_api_gateway_method.debito_method_post
  ]
  rest_api_id = aws_api_gateway_rest_api.bank_account_api.id
  stage_name  = "prod"
}
#####################################################