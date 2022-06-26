# Deployment of FortiGate and Juice-Shop in AWS
## Introduction
This procedure will deploy a FortiGate VM and a AWS Linux2 Server running Juice-shop.  The goal here is to set up a vulnerable web Application that can be used to demonstrate the Capabilities of FortiWeb Cloud.  Students will need to pay close attention to the Requirements section in in order to complete this lab in the allotted time.

## Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 1.0.0
* Terraform Provider AWS >= 3.63.0
* Terraform Provider Template >= 2.2.0
* Completed ITF request for FC1-10-WBCLD-655-02-DD	"FortiWeb-Cloud-WAF-as-a-Service 1 Year FortiWeb Cloud WAF-as-a-Service - Additional 1 web site"
* AWS SE account with:
   - AWS IAM user with:
      - AmazonEC2FullAccess
      - AmazonVPCFullAccess


## Deployment overview
Terraform deploys the following components:
   - AWS VPC with 2 subnets
   - One FortiGate-VM instance with 2 NICs
   - Two Network Security Group rules: one for external, one for internal.
   - Two Route tables: one for internal subnet and one for external subnet.
   - One AWS Linux2 VM with Docker running Juice-Shop (https://github.com/juice-shop/juice-shop)
   - One SSH key for Ubuntu Server (.pem file will be saved to your local folder)



## Deployment
To deploy the FortiGate-VM to AWS:
1. Clone the repository.
2. Customize variables in the `terraform.tfvars.example` and `variables.tf` file as needed.  And rename `terraform.tfvars.example` to `terraform.tfvars`.
3. Initialize the providers and modules:
   ```sh
   $ cd XXXXX
   $ terraform init
    ```
4. Submit the Terraform plan:
   ```sh
   $ terraform plan
   ```
5. Verify output.
6. Confirm and apply the plan:
   ```sh
   $ terraform apply
   ```
7. If output is satisfactory, type `yes`.

Output will include the information necessary to log in to the FortiGate-VM instances:
```sh
FGTPublicIP = <FGT Public IP>
Password = <FGT Password>
Username = <FGT Username>
Server_IP = <Ubuntu Server Private IP>
```


## Destroy the instance
To destroy the instance, use the command:
```sh
$ terraform destroy
```

# Support
Fortinet-provided scripts in this and other GitHub projects do not fall under the regular Fortinet technical support scope and are not supported by FortiCare Support Services.
For direct issues, please refer to the [Issues](https://github.com/fortinet/fortigate-terraform-deploy/issues) tab of this GitHub project.
For other questions related to this project, contact [github@fortinet.com](mailto:github@fortinet.com).

## License
[License](https://github.com/fortinet/fortigate-terraform-deploy/blob/master/LICENSE) © Fortinet Technologies. All rights reserved.



