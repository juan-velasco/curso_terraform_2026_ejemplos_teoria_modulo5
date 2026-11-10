# 03 · Precondiciones y bloques check

```bash
terraform init

# 1. En el workspace "default" la precondición falla: el entorno es "dev"
terraform plan

# 2. En el workspace "dev" se cumple
terraform workspace new dev
terraform plan

# 3. Entorno y workspace distintos: la precondición detiene el plan
terraform plan -var="entorno=pro"

# 4. En el workspace "pro" la precondición se cumple, pero el check AVISA
terraform workspace new pro
terraform plan -var="entorno=pro"

# 5. Con dos servidores, ni error ni aviso
terraform plan -var="entorno=pro" -var="num_servidores=2"
```

Lo importante: en el paso 3 el plan **se detiene** (error; también aparece el aviso del check, porque el entorno es pro con un solo servidor), y en el paso 4 **sigue** con solo un aviso (warning).

Para limpiar:

```bash
terraform workspace select default
terraform workspace delete dev
terraform workspace delete pro
```
