# tf_aws_virttype

Simple terraform module to allow you to look up the type of AMI
you need to use for a particular instance type.

You simply pass the module your ''instance_type'' and it outputs
an ''ami_type_prefer_hvm'' and an ''ami_type_prefer_pv'',
 which will contain either 'hvm' or 'pv'.

You can then use this in your AMI lookup module to work out which
AMI you need.

Data in this module is generated from:

    https://github.com/powdahound/ec2instances.info/blob/master/www/instances.json

Use this in your terraform code like this:

    module "virttype" {
        source = "github.com/terraform-community-modules/tf_aws_virttype"
        instance_type = "m3.xlarge"
    }

And you can then reference:

    "${module.virttypetype.ami_type_prefer_hvm}"

which will return either 'hvm' or 'pv'

The two outputs are given as some instance types support both types
of virtualization (e.g. m3.large), and so you can express a preference
by using one output or the other.

