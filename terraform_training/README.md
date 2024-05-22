# Terraform training
Code created while learning to use AWS and Terraform

<br>

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.67.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_autoscaling"></a> [autoscaling](#module\_autoscaling) | ./modules/autoscaling | n/a |
| <a name="module_databases"></a> [databases](#module\_databases) | ./modules/databases | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.public_ip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.training_autoscaling](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.training_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.training_db2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.training_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.training](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc.training](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_azs"></a> [autoscaling\_azs](#input\_autoscaling\_azs) | n/a | `list(any)` | `[]` | no |
| <a name="input_db_pass"></a> [db\_pass](#input\_db\_pass) | n/a | `string` | `""` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | n/a | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `""` | no |
| <a name="input_network-cidr"></a> [network-cidr](#input\_network-cidr) | n/a | `map(string)` | <pre>{<br>  "p0": "172.16.0.0/16"<br>}</pre> | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | n/a | `string` | `""` | no |
| <a name="input_user_ip"></a> [user\_ip](#input\_user\_ip) | n/a | `string` | `""` | no |
| <a name="input_vm_type"></a> [vm\_type](#input\_vm\_type) | n/a | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->