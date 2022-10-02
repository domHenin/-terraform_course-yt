# Terraform -- Getting a Better Understanding

## Overview

Found new infrastructure to build. this will allow me to get some hands on experience with different AWS services using Terraform. Following this [Guide](https://www.youtube.com/watch?v=7xngnjfIlK4&t=130s)  and provided access this [GitHub Repo](https://github.com/sidpalas/devops-directive-terraform-course) will give me a better understanding using different AWS Services along with Terraform Infrastructure.

-----


<!-- ## Getting Started
---- -->

### Setup IAM Role
using ACG select the provided `ACCESS KEY ID`&& `Secret Access Key`

### TODO:

 - walk through web app TF config
	 - backend + provider config
	 - ec2 instances
	 - s3 bucket
	 - vpc
		 - subnet
	- security groups + rules
	- application load balancer
		- alb target group + attachment
	- route 53  zone + record
	- rds instance

-----

### How Terraform Stores Current State

[Terraform][tfhome] stores cluster state data in
`.terraform/terraform.tfstate` by default. Configuring the `prefix` and
`bucket` variables will enable storage in a remote bucket instead and is
useful for sharing state among multiple administrators. The following
resources provide some useful background information.

### AWS Backend

for the S3 bucket for the aws backend

> AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND


```
 backend "s3" {
  bucket = "provide-unique-s3-bucket-name"
  key = "provide/directory/path/for/.tfstate/terraform.tfstat"
  region = "us-east-1"
  dynamodb_table = "terraform-state-locking" *ignore this block*
  encrypt = true      
  }
  ```
----

## Guides
- [Complete Terraform Guide](https://www.youtube.com/watch?v=7xngnjfIlK4&t=130s)
- [GitHub Repo](https://github.com/sidpalas/devops-directive-terraform-course)

----

### Running Terraform

Run the following to ensure ***terraform*** will only perform the expected
actions:

```sh
terraform plan
```

### Tearing Down the Terraformed Cluster

Run the following to verify that ***terraform*** will only impact the expected
nodes and then tear down the cluster.

```sh
terraform plan
terraform destroy
```
----

[tfhome](https://www.terraform.io)
[tfdocs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)