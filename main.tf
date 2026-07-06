module "vpc"{
    source="./modules/vpc"

}

module "security_group"{
    source="./modules/security-group"
    vpc-id=module.vpc.vpcid
}

module "ec2"{
    source="./modules/ec2"
    security_groups=["module.security_group[*].sgid"]
    subnet_id=module.vpc.subnetid
}
