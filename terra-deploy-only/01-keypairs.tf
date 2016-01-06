#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
/* The Terraform Key-Pair */
resource "openstack_compute_keypair_v2" "terraform-key" {
  name = "terraform-key"
  public_key = "${file("${var.ssh_key_file}.pub")}"
}
