provider "openstack" {
  user_name   = "${var.username}"
  password    = "${var.password}"
  domain_name = "Default"
  auth_url    = "${var.auth_url}"
}

resource "openstack_compute_instance_v2" "iaac_jenkins" {
  name            = "iaac_jenkins"
  image_name      = "Ubuntu 16.04 \"Xenial Xerus\""
  flavor_name     = "v1.m1.d5"
  key_pair        = "iaac_internal"
  security_groups = ["Default"]


  network {
    name = "${var.network_name}"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo apt-get update && sudo apt-get install software-properties-common -y && sudo apt-add-repository ppa:ansible/ansible -y && sudo apt-get update && sudo apt-get install ansible -y",
    ]   
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }

}

resource "openstack_compute_instance_v2" "iaac_jenkins_slave" {
  name            = "iaac_jenkins_slave"
  image_name      = "Ubuntu 16.04 \"Xenial Xerus\""
  flavor_name     = "v1.m1.d5"
  key_pair        = "iaac_internal"
  security_groups = ["Default"]

  network {
    name = "${var.network_name}"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo apt-get update && sudo apt-get install software-properties-common -y && sudo apt-add-repository ppa:ansible/ansible -y && sudo apt-get update && sudo apt-get install ansible -y",
    ]   
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${file(var.private_key_path)}"
  }

}

output "iaac_jenkins" {
 value = "${openstack_compute_instance_v2.iaac_jenkins.access_ip_v4}"
}

output "iaac_jenkins_slave" {
 value = "${openstack_compute_instance_v2.iaac_jenkins_slave.access_ip_v4}"
}
