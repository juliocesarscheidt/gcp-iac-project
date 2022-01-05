# Cloud Build

## Docs

<https://cloud.google.com/build/docs/configuring-builds/substitute-variable-values>

<https://cloud.google.com/build/docs/build-config>


```bash

# sample configuration
git clone https://github.com/GoogleCloudBuild/cloud-console-sample-build && \
  cd cloud-console-sample-build && \
  gcloud builds submit --config cloudbuild.yaml

# list builds
gcloud builds list

# submit a build
gcloud builds submit [SOURCE] --config cloudbuild.yaml

gcloud builds submit [SOURCE] --config cloudbuild.yaml --substitutions _TAG="99edc00"

```
