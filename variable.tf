variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
  type= list(string)
}

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets"
  default = ["10.0.10.0/24", "10.0.20.0/24"]
  type = list(string)
}

variable "private_subnets_cidr" {
  description = "Subnet CIDRs for private subnets"
  default = ["10.0.30.0/24"]
  type = list(string)
}

