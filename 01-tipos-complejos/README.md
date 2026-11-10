# 01 · Variables con tipos complejos

```bash
terraform init
terraform plan
```

En «Changes to Outputs» verás cada valor. Fíjate en `servidores`: el servidor `a` tiene `tipo_instancia = "t3.micro"` y el `b` el mensaje por defecto, aunque `terraform.tfvars` no los indica. Es `optional()`.

Para probar un error de tipo:

```bash
terraform plan -var='red={cidr="10.0.0.0/16", num_zonas="dos", publica=true}'
```

Terraform no puede convertir `"dos"` en un número y se detiene antes del plan.

También puedes explorar los valores con `terraform console`:

```
> var.servidores["b"].mensaje
> var.red.num_zonas + 1
```
