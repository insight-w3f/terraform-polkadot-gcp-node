# terraform-polkadot-gcp-node

[![open-issues](https://img.shields.io/github/issues-raw/insight-w3f/terraform-polkadot-gcp-node?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-gcp-node/issues)
[![open-pr](https://img.shields.io/github/issues-pr-raw/insight-w3f/terraform-polkadot-gcp-node?style=for-the-badge)](https://github.com/insight-w3f/terraform-polkadot-gcp-node/pulls)
[![build-status](https://img.shields.io/circleci/build/github/insight-w3f/terraform-polkadot-gcp-node?style=for-the-badge)](https://circleci.com/gh/insight-w3f/terraform-polkadot-gcp-node)

## Features

This module...

## Terraform Versions

For Terraform v0.12.0+

## Usage

```
module "this" {
    source = "github.com/insight-w3f/terraform-polkadot-gcp-node"

}
```
## Examples

- [defaults](https://github.com/insight-w3f/terraform-polkadot-gcp-node/tree/master/examples/defaults)

## Known  Issues
No issue is creating limit on this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create | Boolean to make module or not | `bool` | `true` | no |
| create\_eip | Boolean to create elastic IP | `bool` | `false` | no |
| environment | The environment | `string` | `""` | no |
| instance\_type | Instance type | `string` | `"n1-standard-1"` | no |
| key\_name | The name of the preexisting key to be used instead of the local public\_key\_path | `string` | `""` | no |
| monitoring | Boolean for cloudwatch | `bool` | `false` | no |
| namespace | The namespace to deploy into | `string` | `""` | no |
| network\_name | The network name, ie kusama / mainnet | `string` | `""` | no |
| node\_name | Name of the node | `string` | `""` | no |
| owner | Owner of the infrastructure | `string` | `""` | no |
| private\_key\_path | The path to the private ssh key | `string` | `""` | no |
| private\_subnet\_id | The id of the private subnet | `string` | n/a | yes |
| public\_key\_path | The path to the public ssh key | `string` | `""` | no |
| public\_subnet\_id | The id of the public subnet | `string` | n/a | yes |
| root\_volume\_size | Root volume size | `string` | `0` | no |
| security\_group\_id | The id of the security group to run in | `string` | n/a | yes |
| stage | The stage of the deployment | `string` | `""` | no |
| validator\_ip | Validator public IP | `string` | `"34.229.64.120"` | no |
| validator\_vpn\_peer\_addr | Validator VPN peer address | `string` | `"172.16.0.1/24"` | no |
| wireguard\_validator\_pubkey | Validator WG public key | `string` | `"jxvsfOegft5FNmd2HSxGQBz/dmCeluk/iWIYrLMuki0="` | no |
| zone | The GCP zone to deploy in | `string` | `"us-east1-b"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_id | n/a |
| private\_ip | n/a |
| private\_subnet\_id | n/a |
| public\_ip | n/a |
| public\_subnet\_id | n/a |
| security\_group\_id | n/a |
| user\_data | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Testing
This module has been packaged with terratest tests

To run them:

1. Install Go
2. Run `make test-init` from the root of this repo
3. Run `make test` again from root

## Authors

Module managed by [Richard Mah](github.com/shinyfoil)

## Credits

- [Anton Babenko](https://github.com/antonbabenko)

## License

Apache 2 Licensed. See LICENSE for full details.