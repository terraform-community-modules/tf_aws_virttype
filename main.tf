variable instance_type {}

output "ami_type_prefer_hvm" {
    value = "${lookup(var.all_ami_types_prefer_hvm, var.instance_type)}"
}

output "ami_type_prefer_pv" {
    value = "${lookup(var.all_ami_types_prefer_pv, var.instance_type)}"
}

