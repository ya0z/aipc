# Automate Infrastructure Provisioning and Configuration Course
## Terraform
```
terraform init
terraform plan
terraform apply
terraform destroy
```
## Ansible
```
ansible-playbook -i inventory.yaml playbook.yaml
```
## Packer
```
packer init config.pkr.hcl
packer build -var-file=variables.pkrvars.hcl images.pkr.hcl
```
