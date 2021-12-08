FROM ubuntu:18.04

ARG TF_VERSION=${TF_VERSION}
ARG TFER_VERSION=${TFER_VERSION}
ARG PROVIDER=${PROVIDER}

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    tzdata \
    apt-transport-https \
    curl \
    locales \
    locales-all \
    unzip \
    python \
    groff \
    nano && \
    # Download and install Terraform
    curl -LO https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin && terraform -install-autocomplete && \
    # Download and install Terraformer
    curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/${TFER_VERSION}/terraformer-${PROVIDER}-linux-amd64 && \
    chmod +x terraformer-${PROVIDER}-linux-amd64 && \
    mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer

WORKDIR /home/terraformer/data
# CMD ["/bin/bash"]

# ENV's
# TF_VERSION
# TFER_VERSION
# PROVIDER
# AWS_SECRET_ACCESS_KEY
# AWS_ACCESS_KEY_ID
# AWS_REGION


# docker build --build-arg TF_VERSION=1.0.11 --build-arg TFER_VERSION=0.8.18 --build-arg PROVIDER=aws --build-arg AWS_SECRET_ACCESS_KEY=*** --build-arg AWS_ACCESS_KEY_ID=*** --build-arg AWS_REGION=eu-west-1 -t my_aws_terraformer .
# docker volume create --name my_aws_terraformer_volume --opt type=none --opt device=/Users/andadmin/Documents/git/andersen_repos/aer_temp/terraformer --opt o=bind
# docker run --rm --name my_aws_terraformer_container --mount source=my_aws_terraformer_volume,target=/home/terraformer -ti my_aws_terraformer /bin/bash