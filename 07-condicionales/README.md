# 07 · Condicionales

```bash
terraform init

# Desarrollo: t3.micro, sin bucket de logs y sin reglas extra
terraform plan

# Producción: t3.small y bucket de logs (1 to add)
terraform plan -var="entorno=pro"

# Reglas extra activadas: 2 to add, ssh y admin
terraform plan -var="crear_reglas_extra=true"

# Todo a la vez: 3 to add
terraform plan -var="entorno=pro" -var="crear_reglas_extra=true"
```

Fíjate en el output `bucket_logs`: en desarrollo ni siquiera aparece, porque vale `null` gracias a `one()`. No da error aunque el recurso no exista; en producción, en cambio, aparece como `(known after apply)`.
