resource "aws_security_group" "sgthis"{
    for_each=toset(local.sg_name)
    name="${each.key} ${local.app-id}"
    vpc_id=var.vpc-id

    lifecycle{
        create_before_destroy=true
    }
    tags={
        name="created_by"
        value="priya"

    }
}

resource "aws_vpc_security_group_ingress_rule" "rule1"{
    for_each = aws_security_group.sgthis

    security_group_id= each.value.id
    cidr_ipv4="10.0.0.0/16"
    ip_protocol="tcp"
    from_port=80
    to_port=80

}


resource "aws_vpc_security_group_egress_rule" "rule1"{
    for_each= aws_security_group.sgthis
    security_group_id= each.value.id
    cidr_ipv4="10.0.0.0/16"

    ip_protocol="tcp"
    from_port=80
    to_port=80

}
output "sgid"{
    value=values(aws_security_group.sgthis)[*].id
}