# Internet VPC
resource "aws_vpc" "VPC" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "${var.ENV}-VPC"
    }
}

# Subnets
resource "aws_subnet" "Public-AZ-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PublicSubnetAZCIDR}"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags = {
        Name = "${var.ENV}-VPC-Public-AZ-SN"
    }
}
# Internet GW
resource "aws_internet_gateway" "Igw" {
    vpc_id = "${aws_vpc.VPC.id}"

    tags = {
        Name = "${var.ENV}-VPC-IGW"
    }
}

#eip
resource "aws_eip" "nat" {
  vpc = true
}

#Nat_gw
resource "aws_nat_gateway" "Ngw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.Public-AZ-SN.id}"

  tags = {
     Name = "${var.ENV}-VPC-NGW"
  }
  depends_on = ["aws_internet_gateway.Igw"]
}
