Deploying the factory
========================
This document purpose is to describe how to use the iaac module in order to deploy the software factory.

# Dependencies
## Terraform

Download https://www.terraform.io/downloads.html
Follow the instruction in the website
export PATH=$PATH:<PATH_TO_TERRAFORM_DIR> >> ~/.bashrc

##Setup
Complete secret.tfvars with the right information about your OpenStack credentials

#Launching
##Run the following command
In your bastion machine run the following commands to create instances:
```
$ terraform init
$ terraform plan
$ terraform apply
```

For the provisionning you should run:
```
$ ./prepare_provision.sh
$ cd ansible
$ ansible-playbook -i hosts main.yml
```

#Congratulation your factory is up and running
