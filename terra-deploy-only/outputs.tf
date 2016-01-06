output "kubemaster" {
    value = "${openstack_compute_floatingip_v2.kubemaster_dev_float.address}"
}

output "kubenode01" {
    value = "${openstack_compute_floatingip_v2.kubenode01_dev_float.address}"
}

output "kubenode02" {
    value = "${openstack_compute_floatingip_v2.kubenode02_dev_float.address}"
}

output "kubenode03" {
    value = "${openstack_compute_floatingip_v2.kubenode03_dev_float.address}"
}

output "kubenode04" {
    value = "${openstack_compute_floatingip_v2.kubenode04_dev_float.address}"
}

output "kubenode05" {
    value = "${openstack_compute_floatingip_v2.kubenode05_dev_float.address}"
}
