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
| [aws_eks_cluster.aws_k8s_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.aws_k8s_node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `string` | `""` | no |
| <a name="input_ec2_ssh_key"></a> [ec2\_ssh\_key](#input\_ec2\_ssh\_key) | n/a | `string` | `""` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | n/a | `list(any)` | <pre>[<br>  "t3.micro"<br>]</pre> | no |
| <a name="input_max_unavailable"></a> [max\_unavailable](#input\_max\_unavailable) | n/a | `number` | `1` | no |
| <a name="input_node_group_scaling"></a> [node\_group\_scaling](#input\_node\_group\_scaling) | n/a | <pre>object({<br>    desired_size = number<br>    max_size     = number<br>    min_size     = number<br>  })</pre> | <pre>{<br>  "desired_size": 1,<br>  "max_size": 2,<br>  "min_size": 1<br>}</pre> | no |
| <a name="input_role"></a> [role](#input\_role) | n/a | `any` | n/a | yes |
| <a name="input_source_security_group_id"></a> [source\_security\_group\_id](#input\_source\_security\_group\_id) | n/a | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `set(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_kubeconfig-certificate-authority-data"></a> [kubeconfig-certificate-authority-data](#output\_kubeconfig-certificate-authority-data) | n/a |
<!-- END_TF_DOCS -->