terraform {
  required_version = ">= 1.5"
}

variable "zonas" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

variable "puertos" {
  type    = list(number)
  default = [80, 443, 8080]
}

variable "servidores" {
  type = map(object({
    tipo    = string
    entorno = string
  }))
  default = {
    a = { tipo = "t3.micro", entorno = "dev" }
    b = { tipo = "t3.small", entorno = "pro" }
    c = { tipo = "t3.small", entorno = "pro" }
  }
}

locals {
  # Lista → lista, entre corchetes
  zonas_en_mayusculas = [for z in var.zonas : upper(z)]

  # Con filtro: solo entran los que cumplen el if
  puertos_sin_8080 = [for p in var.puertos : p if p != 8080]

  # Mapa → mapa, entre llaves y con flecha
  tipo_de_cada_servidor = { for k, s in var.servidores : k => s.tipo }

  # Mapa → lista, con filtro
  servidores_de_produccion = [for k, s in var.servidores : k if s.entorno == "pro"]

  # Lista de objetos…
  reglas = [for p in var.puertos : { puerto = p, descripcion = "Puerto ${p}" }]

  # …y splat: el mismo atributo de cada elemento
  descripciones = local.reglas[*].descripcion
}

output "zonas_en_mayusculas" {
  value = local.zonas_en_mayusculas
}

output "puertos_sin_8080" {
  value = local.puertos_sin_8080
}

output "tipo_de_cada_servidor" {
  value = local.tipo_de_cada_servidor
}

output "servidores_de_produccion" {
  value = local.servidores_de_produccion
}

output "descripciones" {
  value = local.descripciones
}
