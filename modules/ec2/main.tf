resource "aws_instance" "this" {
  #depends_on = [aws_security_group.sgthis]
  # Create one instance per security group id (if you want a single instance, remove for_each)


  vpc_security_group_ids = var.security_groups
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


yum update -y

# Install Docker
yum install -y docker

# Start Docker service
systemctl start docker
systemctl enable docker

# Install AWS CLI
yum install -y awscli

# Login to ECR
aws ecr get-login-password --region us-east-1 | \
docker login --username AWS \
--password-stdin 437952802943.dkr.ecr.us-east-1.amazonaws.com

# Pull Docker image from ECR
docker pull 437952802943.dkr.ecr.us-east-1.amazonaws.com/docker-application:latest

# Stop existing container if running
docker stop springboot-app || true
docker rm springboot-app || true

# Run Spring Boot container
docker run -d \
--name springboot-app \
-p 8080:8080 \
437952802943.dkr.ecr.us-east-1.amazonaws.com/docker-application:latest
  EOF
}

