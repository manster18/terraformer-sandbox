<h1 align="center">Hi 👋, I'm Andrei Grigorovski</h1>
<h3 align="center">DevOps engineer from Belarus</h3>

# terraformer-sandbox
My own solution for running terraformer in docker locally with needed dependencies

### Before running
Before running it you should add your data to the ".env" file. You can use a ".env-example" like an "example" :)


## You can run it in docker using several ways

## Docker run

```
# Build container
$ docker build --build-arg TF_VERSION=1.0.11 --build-arg TFER_VERSION=0.8.18 \
--build-arg PROVIDER=aws --build-arg AWS_SECRET_ACCESS_KEY=*** --build-arg \
 AWS_ACCESS_KEY_ID=*** --build-arg AWS_REGION=eu-west-1 -t my_aws_terraformer .

# Create volume with needed data
$ docker volume create --name my_aws_terraformer_volume \
--opt type=none --opt device=/your/path/to/data --opt o=bind

# Run container
$ docker run --rm --name my_aws_terraformer_container \
--mount source=my_aws_terraformer_volume,target=/home/terraformer -ti my_aws_terraformer /bin/bash
```

## Docker-compose

Just use one simple command:
```
docker-compose up -d
```

## State error and solution for it

After importing your terraform state of infrastructure you should to do the 'terraform init' command and you can get an error, for example:

```
#  terraform init

Initializing the backend...
╷
│ Error: Invalid legacy provider address
│
│ This configuration or its associated state refers to the unqualified provider "aws".
│
│ You must complete the Terraform 0.13 upgrade process before upgrading to later versions.
```

To solve this problem just run several commands:

```
#  terraform state replace-provider -auto-approve "registry.terraform.io/-/aws" "hashicorp/aws"
Terraform will perform the following actions:

  ~ Updating provider:
    - registry.terraform.io/-/aws
    + registry.terraform.io/hashicorp/aws

Changing 2 resources:

  aws_subnet.prod_db
  aws_subnet.prod_app

Successfully replaced provider for 2 resources.
```

After that, your trying to run the 'terraform init' command should be successful!