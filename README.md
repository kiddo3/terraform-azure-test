# Testing Terraform + Azure + saltstack minion installation

## Getting Started

Just an example of creating a vm in azure and installing saltstack minion using terraform 

Prerequisites
-------------
- An [azure account](https://portal.azure.com).
- [Terraform](https://www.terraform.io/intro/getting-started/install.html) software installed. 
- An azure resource group already created.
- A storage account to save the terraform state file and create a Service Principal ([follow this tutorial](https://www.terraform.io/docs/providers/azurerm/authenticating_via_service_principal.html)).

Configuration
-------------
Modify backend_config.tfvars and var_values.tfvars with your values


Commands
--------

#### Create a workspace to store states for differents environments (workspace is optional)
```sh
$ terraform workspace new DEV
```

#### Initialize project (azure storage configured as backend to store tf states)
```sh
$ terraform init -backend-config=backend_config.tfvars
```

#### Switch to the workspace
```sh
$ terraform workspace select DEV
```

#### Create the plan
```sh
$ terraform plan -var-file=var_values.tfvars -out=tf_dev.plan
```

#### Apply the plan
```sh
$ terraform apply tf_dev.plan
```

#### Destroy all the created resources
```sh
$ terraform destroy -var-file=var_values.tfvars
```