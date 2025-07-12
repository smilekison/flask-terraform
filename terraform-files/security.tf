resource "aws_security_group" "flask-security" {
    name_prefix = "dele-"
    tags = {
      "Name" = "flask-security-group"
    }
}

resource "aws_security_group_rule" "http_inbound" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]

    security_group_id = aws_security_group.flask-security.id
}

resource "aws_security_group_rule" "ssh_inbound" {
    security_group_id = aws_security_group.flask-security.id
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  
}

resource "aws_security_group_rule" "flask_inbound_port" {
  security_group_id = aws_security_group.flask-security.id
  type = "ingress"
  from_port = 5000
  to_port = 5000
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "downloads" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
  security_group_id = aws_security_group.flask-security.id
}