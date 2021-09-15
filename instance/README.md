# GCP Instance

## Up and Running

```bash

######## set GCP credential file ########
export GOOGLE_CLOUD_KEYFILE_JSON="$PWD/GOOGLE_CLOUD_KEYFILE_JSON.json"


######## generate ssh key ########
export INSTANCE_USERNAME="google"

ssh-keygen -t rsa -f $PWD/ssh_key -C "${INSTANCE_USERNAME}"
chmod 400 $PWD/{ssh_key,ssh_key.pub}


######## deploy ########
terraform init

terraform validate

terraform plan -var instance_username="${INSTANCE_USERNAME}"

terraform apply -auto-approve -var instance_username="${INSTANCE_USERNAME}"


######## access the instance ########
ssh -i $PWD/ssh_key \
  "${INSTANCE_USERNAME}"@"$(terraform output vm_instance_nat_ip)"


######## clean up ########
terraform destroy -auto-approve

```
