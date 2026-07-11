resource "aws_instance" "this" {
  # Create one instance per security group id (if you want a single instance, remove for_each)
  for_each = toset(var.security_groups)

  security_groups = [eac.value]
  instance_type   = "t2.micro"
  subnet_id       = var.subnet_id
  ami              = data.aws_ami.this.id
  user_data=<<-EOF
  #!bin/bash
  yum update -y
  yum install httpd -y
  systemctl start httpd
  systemctl enable httpd
  echo "installed apache server" 
  EOF
}

