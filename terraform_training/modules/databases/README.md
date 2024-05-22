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
| [aws_db_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_route53_record.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_security_group.DB_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | n/a | `string` | `"postgres"` | no |
| <a name="input_db_pass"></a> [db\_pass](#input\_db\_pass) | n/a | `string` | `""` | no |
| <a name="input_db_storage"></a> [db\_storage](#input\_db\_storage) | n/a | `number` | `10` | no |
| <a name="input_db_type"></a> [db\_type](#input\_db\_type) | n/a | `string` | `"db.t4g.micro"` | no |
| <a name="input_db_user"></a> [db\_user](#input\_db\_user) | n/a | `string` | `""` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | n/a | `string` | `"my.test"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `list(any)` | `[]` | no |
| <a name="input_user_ip"></a> [user\_ip](#input\_user\_ip) | n/a | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_access"></a> [db\_access](#output\_db\_access) | n/a |
<!-- END_TF_DOCS -->