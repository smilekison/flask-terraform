data "aws_key_pair" "existing_key_pair" {
  key_name = "Devops-netflix-clone"
}

resource "aws_instance" "flask_app" {
  ami                         = "ami-044415bb13eee2391"  # Amazon Linux 2 AMI (update as needed)
  instance_type               = "t3.micro"
  key_name                    = data.aws_key_pair.existing_key_pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.flask-security.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt install docker.io -y
              sudo apt install python3-pip -y
              sudo pip3 install psutil flask
              git clone https://github.com/smilekison/flask-terraform.git
              cd flask-terraform
              sudo docker build -t myflaskappv1 .
              sudo docker run -d -p 5000:5000 myflaskappv1
              EOF


  tags = {
    Name = "flask-devops-instance"
  }
}