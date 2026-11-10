terraform {
  required_version = ">= 1.5"
}

# contains(): el valor debe estar en una lista
variable "entorno" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "pre", "pro"], var.entorno)
    error_message = "El entorno debe ser dev, pre o pro."
  }
}

# can(regex()): el valor debe cumplir un patrón
variable "prefijo" {
  type    = string
  default = "ana-lopez"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.prefijo))
    error_message = "El prefijo solo admite minúsculas, números y guiones (entre 3 y 20 caracteres)."
  }
}

# can(cidrhost()): cidrhost da error si el rango no es válido; can() lo convierte en false
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr debe ser un rango CIDR válido, por ejemplo 10.0.0.0/16."
  }
}

# Dos validaciones en la misma variable; alltrue() con una expresión for
variable "puertos" {
  type    = list(number)
  default = [80, 443]

  validation {
    condition     = length(var.puertos) >= 1
    error_message = "Indica al menos un puerto."
  }

  validation {
    condition     = alltrue([for p in var.puertos : p >= 1 && p <= 65535])
    error_message = "Cada puerto debe estar entre 1 y 65535."
  }
}

# length(): entre 1 y 3 elementos
variable "servidores" {
  type    = map(string)
  default = { a = "Servidor A" }

  validation {
    condition     = length(var.servidores) >= 1 && length(var.servidores) <= 3
    error_message = "Debe haber entre 1 y 3 servidores."
  }
}

output "resumen" {
  value = "${var.prefijo}-${var.entorno}: ${length(var.servidores)} servidor(es), puertos ${join(", ", var.puertos)}"
}
