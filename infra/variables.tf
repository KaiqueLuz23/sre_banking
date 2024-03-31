variable "region" {
  type        = list(string)
  description = "região"
  default = ["sa-east-1"]
}
variable "engine" {
  type        = string
  description =  "Engine (Aurora MySQL)"
  default = "aurora-mysql"
}
variable "engine_version" {
  type        = string
  description = "Versão Engine"
  default = "5.7.mysql_aurora.2.04.2"
}

variable "database_name" {
  type        = string
  description = "Nome do DB"
  default = "dbbank"
}

variable "master_username" {
  type        = string
  description = "Nome do DB"
  default = "admin"
}
variable "master_password" {
  type        = string
  description = "Nome do DB"
  default = "dbbankpassword"
}

# Newtwork 
variable "vcp_id" {
  type        = string
  description = "ID VPC"
  default = "$VPC_ID"
}
variable "subnet_ids" {
  type        = list(string)
  description = "Lista de IDs das subnets"
  default = ["$SUBNET_AZ1", "$SUBNET_AZ2"] # AZ1, AZ2
}
variable "sg_rds_id" {
  type        = list(string)
  description = "ID VPC"
  default = ["$SG_RDS_ID"]
}
