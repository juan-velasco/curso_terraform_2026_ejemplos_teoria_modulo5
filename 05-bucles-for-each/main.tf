terraform {
  required_version = ">= 1.5"
}

# 1) for_each sobre un MAPA: each.key es la clave y each.value, su valor
variable "servidores" {
  type = map(object({
    tipo_instancia = optional(string, "t3.micro")
    mensaje        = optional(string, "Servidor creado con Terraform")
  }))
  default = {
    a = { mensaje = "Servidor A" }
    b = { mensaje = "Servidor B" }
    c = { tipo_instancia = "t3.small" }
  }
}

resource "terraform_data" "servidor" {
  for_each = var.servidores

  input = {
    nombre  = "web-${each.key}"
    tipo    = each.value.tipo_instancia
    mensaje = each.value.mensaje
  }

  triggers_replace = each.key
}

# 2) for_each sobre una LISTA DE NÚMEROS: hay que convertirla en un mapa
variable "puertos" {
  type    = list(number)
  default = [80, 443]
}

resource "terraform_data" "regla" {
  for_each = { for p in var.puertos : tostring(p) => p }

  input = "Regla de entrada para el puerto ${each.value}"
}

# 3) for_each sobre una LISTA DE TEXTOS: toset() la convierte y quita repetidos
variable "usuarios" {
  type    = list(string)
  default = ["ana", "luis", "ana"]
}

resource "terraform_data" "usuario" {
  for_each = toset(var.usuarios)

  input = "Usuario ${each.key}" # en un conjunto, each.key y each.value son iguales
}

# Una copia concreta, por su clave
output "servidor_a" {
  value = terraform_data.servidor["a"].output
}

output "nombres_de_servidores" {
  value = [for s in terraform_data.servidor : s.output.nombre]
}
