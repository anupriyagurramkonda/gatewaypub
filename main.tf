# Internet VPC
resource "aws_vpc" "VPC" {
    cidr_block = "${var.VPC_CIDR}"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "${var.ENV}-VPC"
    }
}

# Subnets
resource "aws_subnet" "Public-AZ1-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PublicSubnetAZ1CIDR}"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

    tags {
        Name = "${var.ENV}-VPC-Public-AZ1-SN"
    }
}

resource "aws_subnet" "Public-AZ2-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PublicSubnetAZ2CIDR}"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1b"

    tags {
        Name = "${var.ENV}-VPC-Public-AZ2-SN"
    }
}

resource "aws_subnet" "Private-AZ1-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PrivateSubnetAZ1CIDR}"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1a"

    tags {
        Name = "${var.ENV}-VPC-Private-AZ1-SN"
    }
}
resource "aws_subnet" "Private-AZ2-SN" {
    vpc_id = "${aws_vpc.VPC.id}"
    cidr_block = "${var.PrivateSubnetAZ2CIDR}"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1b"

    tags {
        Name = "${var.ENV}-VPC-Private-AZ2-SN"
    }
}

# Internet GW
resource "aws_internet_gateway" "Igw" {
    vpc_id = "${aws_vpc.VPC.id}"

    tags {
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
  subnet_id     = "${aws_subnet.Public-AZ1-SN.id}"

  tags = {
     Name = "${var.ENV}-VPC-NGW"
  }
  depends_on = ["aws_internet_gateway.Igw"]
}
