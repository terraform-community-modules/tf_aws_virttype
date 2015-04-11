variable instance_type {}

output "prefer_hvm" {
    value = "${lookup(var.prefer_hvm, var.instance_type)}"
}

output "prefer_pv" {
    value = "${lookup(var.prefer_pv, var.instance_type)}"
}

