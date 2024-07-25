variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_a_cidr" {
  description = "The CIDR block for the public subnet in availability zone a"
  type        = string
}

variable "private_subnet_a_cidr" {
  description = "The CIDR block for the private subnet in availability zone a"
  type        = string
}

variable "public_subnet_b_cidr" {
  description = "The CIDR block for the public subnet in availability zone b"
  type        = string
}

variable "private_subnet_b_cidr" {
  description = "The CIDR block for the private subnet in availability zone b"
  type        = string
}

variable "db_name" {
  description = "Name of the database"
  type        = string
}

variable "db_username" {
  description = "Database master username"
  type        = string
}

variable "db_password" {
  description = "Database master password"
  type        = string
}

variable "bucket_name" {
    description = "Name of the S3 bucket"
    type        = string
}

variable "email" {
    description = "Email address for the SNS topic"
    type        = string
}
