# vCenter connection, Replace this with your vcenter FQDN
vsphere_vcenter = "vcenter-eqx-01.force10networks.com"

vsphere_user = "administrator@vsphere.local"

# Replace xxx with the root password. If you're using this to create VM's, you must also know the root password
vsphere_password = "xxx"

vsphere_unverified_ssl = "true"

# VM specifications
vsphere_datacenter = "EQX"

# Replace the below name with the name of the VM you're creating
vsphere_vm_name = "mapatel-tst-01"

vsphere_vm_template = "template/ubuntu1604-template"

vsphere_cluster = "EQX-Access"

# Replace the value below with the number of CPU's needed for the VM
vsphere_vcpu_number = "1"

# Replace the value below with the memory you want for the VM in MB
# For example: 4 GB for a VM, put value 4096
vsphere_memory_size = "1024"

vsphere_datastore_cluster = "EQX-ACCESS"

vsphere_port_group = "Access - M1000 - VLAN 8"

vsphere_scsi_type = "lsilogic"

# Replace the IP with the one you chose from DNS. It has to be on the 10.14.8.x network
vsphere_ipv4_address = "10.14.8.xx"

vsphere_ipv4_netmask = "22"

vsphere_ipv4_gateway = "10.14.11.254"

vsphere_dns_servers = "10.14.1.1"

vsphere_domain = "force10networks.com"

vsphere_time_zone = "PDT"
