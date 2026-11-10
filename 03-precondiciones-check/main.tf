terraform {
  required_version = ">= 1.5"
}

variable "entorno" {
  type    = string
  default = "dev"
}

variable "num_servidores" {
  type    = number
  default = 1
}

# PRECONDICIÓN: si no se cumple, el plan SE DETIENE con un error.
# Compara dos valores: el entorno de las variables y el workspace.
resource "terraform_data" "comprobar_entorno" {
  input = var.entorno

  lifecycle {
    precondition {
      condition     = var.entorno == terraform.workspace
      error_message = "El entorno (${var.entorno}) no coincide con el workspace (${terraform.workspace})."
    }
  }
}

# CHECK: si no se cumple, Terraform solo AVISA (warning) y sigue adelante.
check "produccion_con_dos_servidores" {
  assert {
    condition     = var.entorno != "pro" || var.num_servidores >= 2
    error_message = "En producción conviene tener al menos 2 servidores (hay ${var.num_servidores})."
  }
}
