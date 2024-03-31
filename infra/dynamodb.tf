resource "aws_dynamodb_table" "example" {
  name           = "srebank_dydb"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "documento"
  range_key      = "nome"  

  attribute {
    name = "documento" 
    type = "S"
  }

  attribute {
    name = "nome"
    type = "S"
  }

  attribute {
    name = "saldo"
    type = "N"
  }
  ttl {
    attribute_name = "saldo"
    enabled        = true
  }

  global_secondary_index {
    name            = "saldo_index"
    hash_key        = "saldo"
    projection_type = "ALL"

    write_capacity = 5
    read_capacity  = 5
  }

  tags = {
    Name = "srebank_dydb"
    Project =  "SRE_BANK"
  }
}
