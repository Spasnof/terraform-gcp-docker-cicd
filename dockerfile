FROM hashicorp/terraform:light

# copy over your .tf files
COPY tf_include/*.tf /tf_include/
COPY entrypoint.sh /tf_include

WORKDIR /tf_include

ENTRYPOINT [ "./entrypoint.sh" ]
