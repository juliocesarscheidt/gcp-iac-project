# Commands

## Docs

<https://cloud.google.com/run/docs/mapping-custom-domains>
<https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_domain_mapping>
<https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set>
<https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service>

```bash

######## credentials by environment variables ########
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference
GOOGLE_CREDENTIALS
GOOGLE_CLOUD_KEYFILE_JSON
GCLOUD_KEYFILE_JSON

export GOOGLE_CLOUD_KEYFILE_JSON="$PWD/GOOGLE_CLOUD_KEYFILE_JSON.json"



https://www.google.com/webmasters/verification
https://www.google.com/webmasters/verification/verification?domain=ongcp.blackdevs.com.br

https://search.google.com/search-console


gcloud run services describe cloudrun-service-dev \
  --project vue-project-59c3b \
  --region us-east1

gcloud run services describe cloudrun-service-dev \
  --project vue-project-59c3b \
  --region us-east1 \
  --log-http


gcloud beta run domain-mappings describe \
  --domain cloudrunapp.ongcp.blackdevs.com.br \
  --project vue-project-59c3b \
  --region us-east1



docker image pull juliocesarmidia/http-simple-api:v1.0.0

docker image tag juliocesarmidia/http-simple-api:v1.0.0 gcr.io/vue-project-59c3b/http-simple-api:v1.0.0


# https://cloud.google.com/container-registry/docs/advanced-authentication
gcloud auth configure-docker

cat ~/.docker/config.json
{
  "auths": {
    "https://index.docker.io/v1/": {}
  },
  "credHelpers": {
    "gcr.io": "gcloud",
    "us.gcr.io": "gcloud",
    "eu.gcr.io": "gcloud",
    "asia.gcr.io": "gcloud",
    "staging-k8s.gcr.io": "gcloud",
    "marketplace.gcr.io": "gcloud"
  }
}


# docker image push HOSTNAME/PROJECT-ID/IMAGE:TAG
docker image push gcr.io/vue-project-59c3b/http-simple-api:v1.0.0



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
