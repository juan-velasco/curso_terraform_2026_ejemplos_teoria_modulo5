# Ejemplos de la teoría · Módulo 5

Curso G2601118 · Infraestructura como código con Terraform

Ejemplos pequeños y aislados para acompañar la explicación. **No usan ningún provider**: no necesitan cuenta de AWS ni credenciales, y no crean nada fuera de tu equipo. Los recursos son `terraform_data`, integrado en Terraform: en un proyecto real serían subredes, servidores o reglas.

Requisito: Terraform 1.5 o posterior.

| Carpeta | Diapositiva | Qué muestra |
| --- | --- | --- |
| `01-tipos-complejos` | 7 | list, map, object y map(object) con optional() |
| `02-validaciones` | 8 | validation con contains, can(regex), cidrhost y alltrue |
| `03-precondiciones-check` | 10 | precondition (error) frente a check (aviso) |
| `04-bucles-count` | 11 y 13 | count, count.index, splat y qué pasa al quitar un elemento |
| `05-bucles-for-each` | 12 y 13 | for_each con mapas, listas convertidas y toset |
| `06-expresiones-for-splat` | 14 | for a lista, a mapa, con filtro y splat |
| `07-condicionales` | 15 | ternario, count = cond ? 1 : 0, one() y for_each condicional |

## Cómo usarlos

```bash
cd 01-tipos-complejos
terraform init
terraform plan
```

Cada carpeta tiene un README con los comandos para enseñarlo y lo que se espera ver. En las carpetas 04, 05 y 07 puedes hacer `terraform apply` sin miedo: solo se escribe un `terraform.tfstate` local. Para limpiar, `terraform destroy` o borra el fichero.
