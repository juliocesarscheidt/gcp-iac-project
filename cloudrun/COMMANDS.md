# Commands

```bash

######## gcloud ########
# init gcloud
gcloud init

# list authentication
gcloud auth list

# list config
gcloud config list

# gcloud info about installation
gcloud info


# describe service
gcloud run services describe cloudrun-service-dev \
  --project ${PROJECT_ID} \
  --region us-east1

gcloud run services describe cloudrun-service-dev \
  --project ${PROJECT_ID} \
  --region us-east1 \
  --log-http


# describe domain-mappings
gcloud beta run domain-mappings describe \
  --domain cloudrunapp.${DOMAIN_HOST} \
  --project ${PROJECT_ID} \
  --region us-east1


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

```
