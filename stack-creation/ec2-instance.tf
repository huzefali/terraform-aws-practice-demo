resource "aws_security_group" "ECServerSecurityGroup" {
    name = "ECServerSecurityGroup"
    description = "Enables us to SSH in to our EC2 instance on aws"
    vpc_id = var.VPCID

    ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ECServerSecurityGroup"
  }
}

resource "aws_key_pair" "ec2-key-pair" {
    key_name = "ec2-key-pair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCZmoEYewzW2cgEthUHZHlh6JTYl+qO0LDdLH+xadx/vh3B6OgQz3qNfK0MO+mzf8+hVdsG0rXZPa3SkvWNrFQs+qHO35VFcmWg679zy7cupej8NSM0ECEVMz3Sm8vDfhWmggvqYPTscnNnZpVfE87+sKak62I+DoL7RJ4gI10S1vxWKC2RyiNrT6D3ELwb2MJjTQswb8OE3+sCGMbGUnI93M7/Dr/sW2Yg6blAfX30LbnM8JHaeGvI0HKdpAkHLmNo7+3apP+x71BOMp4lWXj0NThpFPX2zLQR0qJSNRfPl6caWUZRnmSKrHCgcAuVe6Ze22D5cqvvZhBb0C1z0N8H6J4pDC2E+x2iBlzKMQoU+Gizw8/SRCMYZroEtsvT6vv6uPFYyEzZ8rNyqdP6W/MNfmqZlY/+ZjCXOPVZxEyFo0IUs/DN5Uz9+V61DmDj4N7i1xafNlalZjWJlvM/uemQzKJCqcILZq9x3O0unIptlRCTtKzfOSUkL5Pr05ESCwE= alirangwala@Huzefas-MacBook-Pro.local"
    tags = {
      "Name" = "EC2ServerKey"
    }
}

resource "aws_iam_role" "EC2DemoServerInstanceRole" {
  name = "EC2DemoServerInstanceRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        },
        "Action" : [
          "sts:AssumeRole"
        ]
      }
    ]
  })
  managed_policy_arns = []
  tags = {
    Name = "EC2DemoServerInstanceRole"
  }
}
resource "aws_iam_instance_profile" "EC2ServerInstanceProfile" {
  name = "EC2ServerInstanceProfile"
  role = aws_iam_role.EC2DemoServerInstanceRole.name
}

resource "aws_network_interface" "EC2ServerNetworkInterface" {
  subnet_id       = var.SubnetId
  security_groups = [aws_security_group.ECServerSecurityGroup.id]
}

resource "aws_instance" "EC2Server" {
  ami                  = var.InstanceAMI
  instance_type        = var.InstanceType
  key_name             = aws_key_pair.ec2-key-pair.key_name
  iam_instance_profile = aws_iam_instance_profile.EC2ServerInstanceProfile.name

  network_interface {
    network_interface_id  = aws_network_interface.EC2ServerNetworkInterface.id
    device_index          = 0
    delete_on_termination = false
  }
  user_data = file("user-data.sh")
  tags = {
    Name = "EC2Server"
  }
}