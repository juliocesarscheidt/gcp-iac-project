# Commands

```bash

######## credentials by environment variables ########
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
GOOGLE_CREDENTIALS
GOOGLE_CLOUD_KEYFILE_JSON
GCLOUD_KEYFILE_JSON

export GOOGLE_CLOUD_KEYFILE_JSON="$PWD/GOOGLE_CLOUD_KEYFILE_JSON.json"



######## generate ssh key ########
USERNAME=google

ssh-keygen -t rsa -f $PWD/ssh_key -C ${USERNAME}
chmod 400 $PWD/{ssh_key,ssh_key.pub}
ls -lth ssh_key.pub ssh_key


ssh -i $PWD/[KEY_NAME] [USERNAME]@[EXTERNAL_IP]
ssh -i $PWD/ssh_key ${USERNAME}@$(terraform output vm_instance_nat_ip)



######## terraform ########
terraform init
terraform fmt -recursive -write=true
terraform validate
terraform plan
terraform apply -auto-approve
terraform refresh
terraform show
terraform output
terraform destroy -auto-approve



######## gcloud ########
# init gcloud
gcloud init

# list authentication
gcloud auth list

# list config
gcloud config list

# gcloud info about installation
gcloud info

```
