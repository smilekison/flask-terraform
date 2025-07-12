output "appPublicIP" {
  value = aws_instance.flask_app.public_ip
}