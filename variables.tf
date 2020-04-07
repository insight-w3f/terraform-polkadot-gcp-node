variable "create" {
  description = "Boolean to make module or not"
  type        = bool
  default     = true
}

########
# Label
########
variable "environment" {
  description = "The environment"
  type        = string
  default     = ""
}

variable "namespace" {
  description = "The namespace to deploy into"
  type        = string
  default     = ""
}

variable "stage" {
  description = "The stage of the deployment"
  type        = string
  default     = ""
}

variable "network_name" {
  description = "The network name, ie kusama / mainnet"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Owner of the infrastructure"
  type        = string
  default     = ""
}

variable "zone" {
  description = "The GCP zone to deploy in"
  type        = string
  default     = "us-east1-b"
}

#########
# Network
#########
variable "public_subnet_id" {
  description = "The id of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The id of the private subnet"
  type        = string
}

variable "security_group_id" {
  description = "The id of the security group to run in"
  type        = string
}

#####
# Instance
#####
variable "node_name" {
  description = "Name of the node"
  type        = string
  default     = ""
}

variable "monitoring" {
  description = "Boolean for cloudwatch"
  type        = bool
  default     = false
}

variable "create_eip" {
  description = "Boolean to create elastic IP"
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Root volume size"
  type        = string
  default     = 0
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "n1-standard-1"
}

variable "public_key_path" {
  description = "The path to the public ssh key"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The name of the preexisting key to be used instead of the local public_key_path"
  type        = string
  default     = ""
}

variable "private_key_path" {
  description = "The path to the private ssh key"
  type        = string
  default     = ""
}

variable "wireguard_validator_pubkey" {
  description = "Validator WG public key"
  type        = string
  default     = "jxvsfOegft5FNmd2HSxGQBz/dmCeluk/iWIYrLMuki0="
}

variable "validator_vpn_peer_addr" {
  description = "Validator VPN peer address"
  type        = string
  default     = "172.16.0.1/24"
}

variable "validator_ip" {
  description = "Validator public IP"
  type        = string
  default     = "34.229.64.120"
}