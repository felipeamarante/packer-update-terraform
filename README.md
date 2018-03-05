# packer-update-terraform
How to integrate Packer and Terraform locally


## Usage

  * Install Packer and Terraform 
  * Packer will output the ami-id build and inject into terraform inline variables
  * Populate your AWS VPC/Subnet configuration at environment.tf  
  * ``` packer build packerfile.json ```
  * Behold the magic
  
