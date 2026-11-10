# 05 · Bucles con for_each

```bash
terraform init
terraform plan     # 7 to add: 3 servidores, 2 reglas y 2 usuarios (ana solo una vez)
terraform apply    # sin miedo: solo escribe terraform.tfstate en esta carpeta
```

Fíjate en las direcciones con nombre: `terraform_data.servidor["a"]`, `terraform_data.regla["80"]`, `terraform_data.usuario["ana"]`.