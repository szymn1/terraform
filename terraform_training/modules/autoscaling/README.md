<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.test_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_key_pair.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.test_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.test](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_security_group.http_and_this_pc_ssh](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_azs"></a> [autoscaling\_azs](#input\_autoscaling\_azs) | n/a | `list(any)` | `[]` | no |
| <a name="input_autoscaling_params"></a> [autoscaling\_params](#input\_autoscaling\_params) | n/a | <pre>object({<br>    desired_capacity = number<br>    max_size         = number<br>    min_size         = number<br>  })</pre> | <pre>{<br>  "desired_capacity": 1,<br>  "max_size": 3,<br>  "min_size": 2<br>}</pre> | no |
| <a name="input_ebs_vol_size"></a> [ebs\_vol\_size](#input\_ebs\_vol\_size) | n/a | `number` | `8` | no |
| <a name="input_ebs_vol_type"></a> [ebs\_vol\_type](#input\_ebs\_vol\_type) | n/a | `string` | `"gp3"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | n/a | `string` | `""` | no |
| <a name="input_pub_subnet_id"></a> [pub\_subnet\_id](#input\_pub\_subnet\_id) | n/a | `string` | `""` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | n/a | <pre>object({<br>    name    = string<br>    content = string<br>  })</pre> | <pre>{<br>  "content": "",<br>  "name": "AWS labs TEST key"<br>}</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `""` | no |
| <a name="input_user_ip"></a> [user\_ip](#input\_user\_ip) | n/a | `string` | `""` | no |
| <a name="input_vm_type"></a> [vm\_type](#input\_vm\_type) | n/a | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | n/a |
<!-- END_TF_DOCS -->