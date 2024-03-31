# resource "aws_rds_cluster" "example" {
#   cluster_identifier      = "srebank-aurora-cluster"
#   engine                  = var.engine
#   engine_version          = var.engine_version 
#   availability_zones      = var.region
#   #availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]  # Para MultiAZ
#   database_name           = var.database_name
#   master_username         = var.master_username
#   master_password         = var.master_password

#   # Confirgs para FinOps  
#   scaling_configuration {
#     auto_pause              = true  # Ativa o modo de pausa automática para 
#     max_capacity            = 2  # Capacidade máxima de instâncias
#     min_capacity            = 1  # Capacidade mínima de instâncias
#     seconds_until_auto_pause = 300  # Tempo em segundos até que o cluster seja pausado automaticamente após a inatividade
#   }

#   tags = {
#     Name = "srebank-aurora-cluster"
#     Project =  "SRE_BANK"
#     StartWeekDay = "08:00"
#     StopWeekDay = "21:00"
#   }
# }