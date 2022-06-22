
#--------------------------------------------
# Compute resources
#--------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# MKE instances
#-----------------
resource "aws_instance" "manager" {
  count                       = var.manager-nodes-count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance-type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.allow.id]
  key_name                    = var.ssh-key-name

  ebs_block_device {
    device_name           = var.disk-name
    delete_on_termination = true
    volume_size           = var.disk-size
    volume_type           = var.disk-type
  }

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-manager-${count.index}"
  })
}
resource "aws_instance" "worker" {
  count                       = var.worker-nodes-count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance-type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.allow.id]
  key_name                    = var.ssh-key-name

  ebs_block_device {
    device_name           = var.disk-name
    delete_on_termination = true
    volume_size           = var.disk-size
    volume_type           = var.disk-type
  }

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-worker-${count.index}"
  })
}

# MSR instances
#------------------
resource "aws_instance" "msr" {
  count                       = var.msr-nodes-count
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance-type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.allow.id]
  key_name                    = var.ssh-key-name

  ebs_block_device {
    device_name           = var.disk-name
    delete_on_termination = true
    volume_size           = var.disk-size
    volume_type           = var.disk-type
  }

  tags = merge(var.default-tags, {
    Name = "${var.project-name}-msr-${count.index}"
  })
}
