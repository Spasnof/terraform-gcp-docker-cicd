#!/bin/sh
# Note while init consumes a lot of time in the container runtime and could be performed in a 
# multi stage build, it is not done so since this syncs state with remote backend 
# having the state synced at docker build time could possibly lead to a corrupted state.
terraform init

# $@ are the args from the docker run cmd.
terraform $@