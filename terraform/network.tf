#-----------------------------------------
# Network resources
#-----------------------------------------

resource "aws_vpc" "this" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-vpc"
  })
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-gw"
  })
}
data "aws_availability_zones" "list" {
  state = "available"
}
resource "aws_subnet" "public" {
  cidr_block        = cidrsubnet(var.vpc-cidr, 2, 1)
  vpc_id            = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.list.names[0]

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-public"
  })
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-public-rt"
  })
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}
data "external" "whatismyip" {
  program = ["/bin/bash", "${path.module}/whatismyip.sh"]
}
resource "aws_security_group" "allow" {
  name        = "allow"
  description = "Allow what we need"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.external.whatismyip.result.myip}/32", cidrsubnet(var.vpc-cidr, 2, 1)]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project-name}-allow"
  }
}
