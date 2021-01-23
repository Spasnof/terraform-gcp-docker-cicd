#!/bin/sh
# validate that the .tf files are all properly formatted
if terraform fmt -check ; then
    echo "All .tf files are formatted correctly"
else
    echo "uhoh make sure you have run: terraform fmt"
    exit 1
fi
# Note while init consumes a lot of time in the container runtime and could be performed in a 
# multi stage build, it is not done so since this syncs state with remote backend 
# having the state synced at docker build time could possibly lead to a corrupted state.
terraform init



# $@ are the args from the docker run cmd.
terraform $@