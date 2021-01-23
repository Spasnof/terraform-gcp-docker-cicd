FROM hashicorp/terraform:light

# copy over your files
COPY tf_include/* /tf_include/
COPY entrypoint.sh /tf_include

WORKDIR /tf_include

ENTRYPOINT [ "./entrypoint.sh" ]
