Example of a docker image to perform terraform changes within gcp

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
  - Add a service account (SA) with the roles to perform it's job and save your token as `secrets\terraform-docker-cicd.json`
    - must include ability to read/write from the gcs tf state bucket
  - Create a gcs tf state bucket and update `tf_include\main.tf` with the bucket_id
2. Build and run the image with a plan
  ```
  docker build -t gcp-tf-cidc:dev . ; docker run -v $PWD\secrets\terraform-docker-cicd.json:/tf_include/terraform-docker-cicd.json:ro gcp-tf-cidc:dev
```