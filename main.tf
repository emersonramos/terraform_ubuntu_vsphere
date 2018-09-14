# Below is the code for Dell Networking usage for creating VMs from EQX vCenter
# The below script is the primary endpoint while using this module
# Basically clones a template to create a Ubuntu 16.04 vm as desired
#===============================================================================
# vSphere Provider
#===============================================================================
# Below is the main provider we're using for contacting our vCenter
provider "vsphere" {
  version        = "1.5.0"
  vsphere_server = "${var.vsphere_vcenter}"
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"

  allow_unverified_ssl = "${var.vsphere_unverified_ssl}"
}

#===============================================================================
# vSphere Data
#===============================================================================
# Basic data fetched to use for configuration

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore_cluster" "datastore_cluster" {
  name          = "${var.vsphere_datastore_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vsphere_port_group}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_vm_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#===============================================================================
# vSphere Resources
#===============================================================================

resource "vsphere_virtual_machine" "vm" {
  # VM placement #
  name             = "${var.vsphere_vm_name}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_cluster_id     = "${data.vsphere_datastore_cluster.datastore_cluster.id}"

  # VM resources #
  num_cpus = "${var.vsphere_vcpu_number}"
  memory   = "${var.vsphere_memory_size}"

  scsi_type = "${var.vsphere_scsi_type}"  

  # Guest OS #
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  # VM storage #
  disk {
    label            = "${var.vsphere_vm_name}.vmdk"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
  }

  # VM networking #
  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  # Customization of the VM #
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "${var.vsphere_vm_name}"
        domain    = "${var.vsphere_domain}"
        time_zone = "${var.vsphere_time_zone}"
      }

      network_interface {
        ipv4_address = "${var.vsphere_ipv4_address}"
        ipv4_netmask = "${var.vsphere_ipv4_netmask}"
      }

      ipv4_gateway    = "${var.vsphere_ipv4_gateway}"
      dns_server_list = ["${var.vsphere_dns_servers}"]
      dns_suffix_list = ["${var.vsphere_domain}"]
    }
  }
}
