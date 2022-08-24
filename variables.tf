#Create Locations - Availability Zones
variable "avzs" {
  default = ["uksouth", "ukwest", "eastus", "westeurope"]
}


#Prefix for Corporation
variable "corp" {
  default = "corporate"
}


variable "env" {
  default = "Static"
}


variable "tenant_id" {
  type = string
  default = "36b6838b-d41b-4ef5-8c96-abd06907a34e"
}


#Corporate Naming Convention Prefix for Virtual Machine Environments -"${var.corp}-${var.mgmt}-vm01"
variable "mgmt" {
  description = "corporate naming convention prefix"
  default     = "management"

}


#Specify type of resource being deployed here - "${var.corp}-${var.mgmt}-${var.webres[0]}-01"
variable "webres" {
  default = ["vm", "webapp", "slb", "appgw"]
}



#Load  Balancer Constructs
variable "private_ip" {
  default = "10.20.10.100"
}


#NFS Folders

variable "nfs_fs" {
  default = "home"
}

variable "nfs_fs_prod" {
  default = "prod"
}
variable "nfs_fs_staging" {
  default = "staging"
}
variable "nfs_fs_dev" {
  default = "dev"
}


#Security Access
variable "rdp_access_port" {
  description = "dedicated rdp port for management host access"
  default     = 3389

}

variable "ssh_access_port" {
  description = "dedicated ssh port for webserver shell access"
  default     = 22

}