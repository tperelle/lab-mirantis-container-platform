#--------------------------
# General parameters
#--------------------------
variable "owner" {
  type    = string
  default = "Thomas Perelle"
}

variable "project-name" {
  type    = string
  default = "mirantis"
}

variable "default-tags" {
  type = map(string)
  default = {
    app_env  = "dev"
    app_name = "mirantis"
    owner    = "Thomas Perelle"
  }
}

#--------------------
# Network parameters
#--------------------
variable "vpc-cidr" {
  type    = string
  default = "125.0.0.0/20"
}

#--------------------------
# Instances parameters
#--------------------------
variable "ssh-key-name" {
  type    = string
  default = "tpe"
}
variable "instance-type" {
  type    = string
  default = "t2.large"
}
variable "disk-size" {
  type    = number
  default = 50
}
variable "disk-type" {
  type    = string
  default = "gp2"
}
variable "disk-name" {
  type    = string
  default = "/dev/sda1"
}

#----------------------------
# Cluster configuration
#----------------------------
variable "cluster-name" {
  type    = string
  default = "poc-cluster"
}
variable "manager-nodes-count" {
  type    = number
  default = 1
}
variable "worker-nodes-count" {
  type    = number
  default = 1
}
variable "msr-nodes-count" {
  type    = number
  default = 1
}
variable "mke-version" {
  type    = string
  default = "3.5.3"
}
variable "msr-version" {
  type    = string
  default = "2.9.7"
}
variable "mcr-version" {
  type    = string
  default = "20.10.0"
}
variable "ssh-private-key" {
  type    = string
  default = "~/.ssh/id_rsa"
}
variable "admin-username" {
  type    = string
  default = "admin"
}
variable "admin-password" {
  type    = string
  default = "MySecuredPassword"
}
