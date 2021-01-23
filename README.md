Example of a docker image to perform terraform changes within gcp. This is useful in encapsulating the terraform setup for CI/CD pipelines etc.

# TODO 
- [X] make a project / enable the compute api
- [X] make a sa/token
- [X] make a local valid main.tf/variables.tf
- [X] build the base docker image
- [X] have the init/plan/apply/destroy work within the image
- [X] mount a secret at runtime with a -v
- [X] make a backend bucket and test
- [ ] add a exception handling using `-check `

# Quickstart
### windows powershell

1. Create and setup your gcp project.
  - update the `tf_include\variables.tf` file with your project name
  - Enable api's you want to create resources under.
  - Add a service account (SA) with the roles to perform it's job and save your token as `.\tf_include\terraform-docker-cicd.json`
    - You must grant the SA read/write roles to your gcs tf state bucket
  - Create a gcs tf state bucket and update `.\tf_include\main.tf` with the bucket_id
1. Add any resources you want as .tf files within the `.\tf_include` dir.
    - The examples show two type of failure (.tf files that were not formatted and just a malformed .tf file)
    - The example also shows a basic working example from the google module terraform docs.
1. Build and run the image with a plan
  - This will ensure that your
  ```
  docker build -t gcp-tf-cidc:dev . ; docker run -v $PWD\tf_include\terraform-docker-cicd.json:/tf_include/terraform-docker-cicd.json:ro gcp-tf-cidc:dev
```