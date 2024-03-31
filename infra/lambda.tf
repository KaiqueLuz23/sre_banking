#####################################################
# CREATE
# Definição da função Lambda
resource "aws_lambda_function" "bank_account_lambda" {
  filename      = data.archive_file.lambda_zip.output_path 
  function_name = "bank_account_lambda"  # Nome da função Lambda
  role          = aws_iam_role.lambda_exec_role.arn  
  handler       = "bank_account_lambda.lambda_handler" 
  runtime       = "python3.8"  
  tags = {
    Name = "bank_account_lambda"
    Project =  "SRE_BANK"
  }
}
# Criação do arquivo ZIP contendo o código da função Lambda
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "bank_account_lambda.zip"  
  source {
    content  = file("../app/bank_account_lambda.py")  
    filename = "bank_account_lambda.py"  
  }
}
# Permissão para o API Gateway invocar a função Lambda
resource "aws_lambda_permission" "apigw_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.bank_account_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.bank_account_api.execution_arn}/*/*"  # ARN da execução do API Gateway
}
#####################################################


#####################################################
# EXTRATO
# Definição da função Lambda Extrato
resource "aws_lambda_function" "extrato_account_lambda" {
  filename      = data.archive_file.extrato_lambda_zip.output_path
  function_name = "extrato_account_lambda"  # Nome da função Lambda
  role          = aws_iam_role.lambda_exec_role.arn  
  handler       = "extrato_account_lambda.lambda_handler" 
  runtime       = "python3.8"  
  tags = {
    Name = "extrato_account_lambda"
    Project =  "SRE_BANK"
  }
}
# Criação do arquivo ZIP contendo o código da função Lambda Extrato
data "archive_file" "extrato_lambda_zip" {
  type        = "zip"
  output_path = "extrato_account_lambda.zip"  
  source {
    content  = file("../app/extrato_account_lambda.py")  
    filename = "extrato_account_lambda.py"  
  }
}
# Permissão para o API Gateway invocar a função Lambda Extrato
resource "aws_lambda_permission" "extrato_apigw_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.extrato_account_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.bank_account_api.execution_arn}/*/*"  # ARN da execução do API Gateway
}
#####################################################
# pix
# Definição da função Lambda Extrato
resource "aws_lambda_function" "pix_account_lambda" {
  filename      = data.archive_file.pix_lambda_zip.output_path
  function_name = "pix_account_lambda"  # Nome da função Lambda
  role          = aws_iam_role.lambda_exec_role.arn  
  handler       = "pix_account_lambda.lambda_handler" 
  runtime       = "python3.8"  
  tags = {
    Name = "pix_account_lambda"
    Project =  "SRE_BANK"
  }
}
# Criação do arquivo ZIP contendo o código da função Lambda Extrato
data "archive_file" "pix_lambda_zip" {
  type        = "zip"
  output_path = "pix_account_lambda.zip"  
  source {
    content  = file("../app/pix_account_lambda.py")  
    filename = "pix_account_lambda.py"  
  }
}
# Permissão para o API Gateway invocar a função Lambda Extrato
resource "aws_lambda_permission" "pix_apigw_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.pix_account_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_deployment.bank_account_api.execution_arn}/*/*"  # ARN da execução do API Gateway
}