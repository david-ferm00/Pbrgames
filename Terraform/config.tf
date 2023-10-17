# Converting the user-readable Container Linux Configuration in flatcar_config.yaml
# into a machine-readable Ignition config file using the "Config Transpiler" ct.
# Also performs some template magic on this file to import the ssh keys to use.
data "ct_config" "flatcar" {
    strict = true
    pretty_print = false

    # Render the template in the given file
    content = templatefile("${path.module}/flatcar_config.yaml", {
        # Use these values to fill the template
        sshkey = file("${path.module}/id_rsa.pub")
        imagename = var.imagename
        ip = openstack_networking_floatingip_v2.float_ip.address
    })
}

data "ct_config" "worker" {
    strict = true
    pretty_print = false

    # Render the template in the given file
    content = templatefile("${path.module}/flatcar_workerOne.yaml", {
        # Use these values to fill the template
        sshkey = file("${path.module}/id_rsa.pub")
        imagename = var.imagename
        ip = openstack_networking_floatingip_v2.float_ip.address
    })
}