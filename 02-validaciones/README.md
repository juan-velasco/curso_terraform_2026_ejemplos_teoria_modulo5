# 02 · Validaciones

Con los valores por defecto, todo es válido:

```bash
terraform init
terraform plan
```

Ahora, provoca cada error. Terraform se detiene antes del plan y muestra el `error_message`:

```bash
terraform plan -var="entorno=test"
terraform plan -var="prefijo=Ana_Lopez"
terraform plan -var="vpc_cidr=10.0.0.0/33"
terraform plan -var='puertos=[]'
terraform plan -var='puertos=[80, 70000]'
terraform plan -var='servidores={a="1", b="2", c="3", d="4"}'
```

En PowerShell, las comillas simples funcionan igual; en `cmd` usa comillas dobles y escápalas con `\"`.

Nota: `terraform validate` comprueba la sintaxis, pero no evalúa las validaciones con los valores que pases: para eso hace falta `terraform plan`.
