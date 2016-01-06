#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
# This is the variables file:
# THIS IS THE ONLY FILE YOU SHOULD NEED TO EDIT
# Follow the instructions. I have included a terraform plan to help
# place some normacy around the variables given below.
#
/* The Terraform Provider */
# Kubemaster and Kubenode images can be Fedora/Centos.
# You can use Atomic, but change your 05-10 Kubemaster/Kubenode files to reflect these changes.
variable "kubemaster_image" {
    default = "<openstack image list>"
}

variable "kubenode_image" {
    default = "<openstack image list>"
}

variable "kubemaster_flavor" {
    default = "<openstack flavor list>"
}

variable "kubenode_flavor" {
    default = "<openstack flavor list>"
}

# Key used for for logging into your hosts. Whatever is in ~/.ssh/<key>
variable "ssh_key_file" {
    default = "~/.ssh/id_rsa"
}

# Key used for for logging into your hosts. Whatever is in ~/.ssh/<key.pub>. This will be uploaded to Openstack.
variable "ssh_key_file_pub" {
    default = "~/.ssh/id_rsa.pub"
}
variable "ssh_key_hash" {
    default = "<additional-key-hash>"
}
variable "kubemaster_ssh_user_name" {
    default = "fedora"
}

variable "kubenode_ssh_user_name" {
    default = "fedora"
}

# Can be anything. Terraform will create a new network for you.
variable "cidr" {
    default = "10.8.80.0/24"
}

# Actual working DNS value.
variable "dns" {
    default = "192.168.1.70"
}

# Edit if you change the CIDR above.
variable "kubemaster_fixed_ipv4" {
    default = "10.8.80.10"
}

# Edit if you change the CIDR above.
variable "kubenode01_fixed_ipv4" {
    default = "10.8.80.11"
}

# Edit if you change the CIDR above.
variable "kubenode02_fixed_ipv4" {
    default = "10.8.80.12"
}

# Edit if you change the CIDR above.
variable "kubenode03_fixed_ipv4" {
    default = "10.8.80.13"
}

# Edit if you change the CIDR above.
variable "kubenode04_fixed_ipv4" {
    default = "10.8.80.14"
}

# Edit if you change the CIDR above.
variable "kubenode05_fixed_ipv4" {
    default = "10.8.80.15"
}

# Your public facing network in openstack.
variable "pub_pool" {
    default = "<openstack network list>"
}

# Your private facing network in openstack.
variable "pri_pool" {
    default = "<openstack network list>"
}

variable "external_gateway" {
    default = "<network id from public network>"
}

variable "internal_gateway" {
    default = "<network id from private network>"
}

variable "root_password" {
    default = "changeme"
}

# I only used this in testing...it won't be used by default
variable "cloud_config" {
    default = "kubenode/cloud-config.yaml"
}
