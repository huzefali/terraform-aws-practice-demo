variable "VPCID" {
    description = "default vpc from aws"
    type = string
    default = "vpc-02443b0e5dd952828"
}

variable "SubnetId" {
    description = "default subnet from aws"
    type = string
    default = "subnet-0a156bd4ef0f55886"
}

variable "InstanceAMI" {
    description = "EC2 instance ami"
    type = string
    default = "ami-0574da719dca65348" 
}

variable "InstanceType" {
    description = "ec2 instance type"
    type = string
    default = "t2.micro"
}


variable "S3Bucket" {
  description = "S3 Bucket"
  type = string
  default = "s3-demo-bucket-terraform"
}

variable "S3CodeZip" {
  description = "S3 code zip file storage"
  type = string
  default = "raw-data-application.zip"
}