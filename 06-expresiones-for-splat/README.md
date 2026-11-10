# 06 · Expresiones for y splat

```bash
terraform init
terraform plan
```

En «Changes to Outputs» verás el resultado de cada expresión:

| Output | Resultado |
| --- | --- |
| `zonas_en_mayusculas` | `["EU-WEST-1A", "EU-WEST-1B"]` |
| `puertos_sin_8080` | `[80, 443]` |
| `tipo_de_cada_servidor` | `{ a = "t3.micro", b = "t3.small", c = "t3.small" }` |
| `servidores_de_produccion` | `["b", "c"]` |
| `descripciones` | `["Puerto 80", "Puerto 443", "Puerto 8080"]` |

Para experimentar en vivo:

```bash
terraform console
> [for z in var.zonas : "${z}-subred"]
> { for k, s in var.servidores : k => upper(s.entorno) }
> local.reglas[*].puerto
```
