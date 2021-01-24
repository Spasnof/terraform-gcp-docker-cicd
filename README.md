Example of a docker image to perform terraform changes within gcp. This is useful in encapsulating the terraform setup for CI/CD pipelines etc.

# Quickstart
### Dependecies
  - Docker
  - A gcp account

### Windows powershell
1. Clone this rep and configure your gcp project.
  - update the `tf_include\variables.tf` file with your project name
  - Enable api's you want to create resources under.
  - Add a service account (SA) with the roles to perform it's job and save your token as `.\tf_include\terraform-docker-cicd.json`
    - You must grant the SA read/write roles to your gcs tf state bucket
  - Create a gcs tf state bucket and update `.\tf_include\main.tf` with the bucket_id
1. Add any resources you want as .tf files within the `.\tf_include` dir.
    - The examples show two type of failure (.tf files that were not formatted and just a malformed .tf file)
    - The example also shows a basic working example from the google module terraform docs.
1. Build and run the image with a plan
  - This will ensure that it builds and can run.
    ```
    docker build -t gcp-tf-cidc:dev . ; docker run -v $PWD\tf_include\terraform-docker-cicd.json:/tf_include/terraform-docker-cicd.json:ro gcp-tf-cidc:dev plan
    ```
3. Go ahead and plan/apply/destroy to your hearts content. ie
   - `docker run -v $PWD\tf_include\terraform-docker-cicd.json:/tf_include/terraform-docker-cicd.json:ro gcp-tf-cidc:dev plan`
   - `docker run -v $PWD\tf_include\terraform-docker-cicd.json:/tf_include/terraform-docker-cicd.json:ro gcp-tf-cidc:dev apply -auto-approve`
   - `docker run -v $PWD\tf_include\terraform-docker-cicd.json:/tf_include/terraform-docker-cicd.json:ro gcp-tf-cidc:dev destroy -auto-approve`

# Intended development flow
1. Fork/Clone the repo go through the quickstart to get setup. __Remember to secure your secrets!__
1. Deploy the built image to your CI/CD enviroment.
  - On a PR push run the plan for the branch. This should check for any syntax errors and ensure that `terraform fmt` is properly applied.
  - On merge it would be suggested that people manually plan -> apply so as to give them a chance to read the plan and ensure they are comfortable with the intended changes.

# Notes
- There may be an issue with not saving the .terraform.lock.hcl file.
The following is shown any time the container is run.
> Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future