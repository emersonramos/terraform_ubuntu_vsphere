# terraform_ubuntu16

This is a simple Terraform module to deploy an Ubuntu 16.04 virtual machine on EQX vSphere vCenter of Dell Networking.

Files:

- main.tf = This is the main configuration file which contains all the backend infrastructure code to setup our VM.

- variables.tf = This file contains all the variable definitions used in the module.

- terraform.tfvars = This file is where the user of this module will input some of the variables needed according to the VM needed to be created.


Must Do's while using this module:

- You must always create a separate directory for creating new VMs. DONOT try to create VM from the same directory you created using this Terraform module before. If you try to create VM from the same direcrtory by changing variables, it will destroy your previous VM before creating the new one.
- You must always name the VM with its DNS name. It would be ideal if you already have it added in DNS with a unique IP address. 
- Be careful in passing the variable values as to not duplicate it from any other VMs. Check the DNS name and IP address before using so as to confirm it is unique.


Steps to utilize this module after clone:

- Clone this module into the directory of your choice: 'git clone ssh://git@stash.force10networks.com/ro/terraform_ubuntu16.git'
- In your cloned directory, do a 'terraform init'
- ALWAYS do a 'terraform plan' and take a look at the changes that are going to happen, sort of a dry run and fix if any errors.
- If you're satisfied with the planned changes, run 'terraform apply' and enter 'yes' when it prompts you to confirm.
- Wait, for the process to end and once it is done, ssh to your VM and start working.


Support:

If you have any questions in using this module, contact Mithil.Patel@Dell.com

