# terraform-bootcamp-env
## Launch bootcamp-1 
1. gcloud login `gcloud auth application-default login`
2. go to `environments/bootcamp-1`
3. edit variables inside *bootcamp.tfvars*
4. run 
```
terraform init
terraform plan -out plan.out -var-file=bootcamp.tfvars
terraform apply plan.out
```
5. once you have done `terraform destroy -var-file=bootcamp.tfvars`
