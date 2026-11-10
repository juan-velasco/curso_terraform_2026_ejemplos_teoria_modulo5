terraform {
  required_version = ">= 1.5"
}

# Lista: elementos ordenados del mismo tipo
variable "zonas" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b"]
}

# Mapa: claves de texto y todos los valores del mismo tipo
variable "etiquetas" {
  type = map(string)
  default = {
    Curso   = "G2601118"
    Entorno = "dev"
  }
}

# Objeto: cada atributo con su nombre y su propio tipo
variable "red" {
  type = object({
    cidr      = string
    num_zonas = number
    publica   = bool
  })
  default = {
    cidr      = "10.0.0.0/16"
    num_zonas = 2
    publica   = true
  }
}

# Mapa de objetos con atributos opcionales: el caso del ejercicio.
# Si un servidor no indica un atributo, toma el valor de optional().
variable "servidores" {
  type = map(object({
    tipo_instancia = optional(string, "t3.micro")
    mensaje        = optional(string, "Servidor creado con Terraform")
  }))
}

# Cómo se leen
output "primera_zona" {
  value = var.zonas[0]
}

output "entorno" {
  value = var.etiquetas["Entorno"]
}

output "cidr_de_la_red" {
  value = var.red.cidr
}

# Fíjate en que Terraform rellena los atributos que no se indicaron
output "servidores" {
  value = var.servidores
}
