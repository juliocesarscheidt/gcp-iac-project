# GCP CloudRun

## Up and Running

```bash

######## set GCP credential file ########
export GOOGLE_CLOUD_KEYFILE_JSON="$PWD/GOOGLE_CLOUD_KEYFILE_JSON.json"


######## configure docker with GCP registry ########
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


######## push image to GCP registry ########
export PROJECT_ID="YOUR_GCP_PROJECT_ID"
export IMAGE_NAME="http-simple-api"
export IMAGE_TAG="v1.0.0"

docker image pull "juliocesarmidia/${IMAGE_NAME}:${IMAGE_TAG}"

docker image tag \
  "juliocesarmidia/${IMAGE_NAME}:${IMAGE_TAG}" \
  "gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"

docker image push "gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"


# in order to deploy with a domain-mapping, verifying the domain on google is required, the link is the following:
https://www.google.com/webmasters/verification
https://www.google.com/webmasters/verification/verification?domain=${DOMAIN_HOST}
# the search console
https://search.google.com/search-console


######## deploy ########
terraform init

terraform validate

terraform plan \
  -var image_name="${IMAGE_NAME}" \
  -var image_tag="${IMAGE_TAG}" \
  -var cloud_mapping_enabled=false

terraform apply \
  -auto-approve \
  -var image_name="${IMAGE_NAME}" \
  -var image_tag="${IMAGE_TAG}" \
  -var cloud_mapping_enabled=false

######## test the service ########
curl -X GET --url "$(terraform output cloudrun_service_url)"

######## clean up ########
terraform destroy -auto-approve

```
