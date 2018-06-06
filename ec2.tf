# AWS EC2
module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "tf-client"
  instance_count = 2

  ami                    = "ami-4bf3d731"
  instance_type          = "t2.micro"
  key_name               = "${var.key}"
  monitoring             = true
  vpc_security_group_ids = ["${var.sg}"]
  #vpc_security_group_ids = ["sg-25a7136d"]
  subnet_id              = "subnet-fd5fd3a6"

  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
    Name        = "tf-client"
  }
}

# AWS SG
module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "example"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = "${data.aws_vpc.default.id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

