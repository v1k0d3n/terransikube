#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
/* Create the Network " ext-net */
resource "openstack_networking_network_v2" "ext_net" {
  name = "ext_net"
  admin_state_up = "true"
}

/* Create the Subnet "dev-ext-sub" */
resource "openstack_networking_subnet_v2" "dev-ext-sub" {
  name = "dev-ext-sub"
  network_id = "${openstack_networking_network_v2.ext_net.id}"
  cidr = "${var.cidr}"
  ip_version = 4
  dns_nameservers = ["${var.dns}"]
}

resource "openstack_networking_router_v2" "dev-ext" {
  name = "dev_router"
  admin_state_up = "true"
  external_gateway = "${var.external_gateway}"
}

resource "openstack_networking_router_interface_v2" "dev-rtr" {
  router_id = "${openstack_networking_router_v2.dev-ext.id}"
  subnet_id = "${openstack_networking_subnet_v2.dev-ext-sub.id}"
}
