terraform {
  required_version = ">= 1.5"
}

variable "zonas" {
  type    = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

# count = N crea N copias; count.index es su posición: 0, 1, 2…
resource "terraform_data" "subred" {
  count = length(var.zonas)

  input = {
    zona = var.zonas[count.index]
    cidr = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  }

  # Como una subred real: si cambia su zona, hay que crearla de nuevo
  triggers_replace = var.zonas[count.index]
}

# Una copia concreta, por su posición
output "primera_subred" {
  value = terraform_data.subred[0].output
}

# Splat [*]: el mismo atributo de todas las copias, en una lista
output "todas_las_subredes" {
  value = terraform_data.subred[*].output
}
