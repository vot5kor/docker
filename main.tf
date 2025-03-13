resource "aws_instance" "This"{
    ami     = "ami-09c813fb71547fc4f"
    instance_type = "t3.micro"
    vpc_security_group_ids  = [aws_security_group.allow_docker.id]
   
    #20gb not enough
    root_block_device {
        volume_size = 50 # set root  volume size to 50
        volume_type = "gp3" # use gp3 for better performance(optional)

    }
    user_data = file("docker.sh")

    tags = {
      Name = "docker"
    }
}


resource "aws_security_group" "allow_docker" {
  name              = "allow_docker001"
  description       = "allow tls inbound trafic and all outbound traffic"
  # vpc_id            = "vpc-035f44c2894cbe3b3"
 ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
 } 
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}