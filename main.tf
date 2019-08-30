# Internet VPC
resource "aws_vpc" "VPC" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "${var.name}-VPC"
    }
}

# Subnets
resource "aws_subnet" "SN-AZ" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.subnet_cidr}"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.subnet_az}"

    tags = {
        Name = "${var.name}-VPC-SN-AZ"
    }
}
# Internet GW
resource "aws_internet_gateway" "Igw" {
    vpc_id = "${aws_vpc.VPC.id}"

    tags = {
        Name = "${var.name}-VPC-IGW"
    }
}

#eip
resource "aws_eip" "nat" {
  vpc = true
}

#Nat_gw
resource "aws_nat_gateway" "Ngw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.SN-AZ.id}"

  tags = {
     Name = "${var.name}-VPC-NGW"
  }
  depends_on = ["aws_internet_gateway.Igw"]
}
