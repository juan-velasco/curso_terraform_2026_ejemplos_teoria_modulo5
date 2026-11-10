terraform {
  required_version = ">= 1.5"
}

variable "entorno" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "pre", "pro"], var.entorno)
    error_message = "El entorno debe ser dev, pre o pro."
  }
}

variable "crear_reglas_extra" {
  type    = bool
  default = false
}

variable "reglas_extra" {
  type    = map(number)
  default = { ssh = 22, admin = 8080 }
}

locals {
  es_produccion = var.entorno == "pro"

  # Ternario: condición ? valor_si_true : valor_si_false
  tipo_instancia = local.es_produccion ? "t3.small" : "t3.micro"
}

# Crear un recurso solo si se cumple algo: count 1 o 0
resource "terraform_data" "bucket_logs" {
  count = local.es_produccion ? 1 : 0

  input = "logs-${var.entorno}"
}

# Con for_each: un mapa vacío no crea nada
resource "terraform_data" "regla_extra" {
  for_each = var.crear_reglas_extra ? var.reglas_extra : {}

  input = "Regla ${each.key}: puerto ${each.value}"
}

output "tipo_instancia" {
  value = local.tipo_instancia
}

# one(): el único elemento de la lista, o null si está vacía
output "bucket_logs" {
  value = one(terraform_data.bucket_logs[*].output)
}

output "reglas_extra" {
  value = keys(terraform_data.regla_extra)
}
