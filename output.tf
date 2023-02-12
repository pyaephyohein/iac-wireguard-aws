output "wireguard_instance_ip" {
  value = aws_instance.wireguard.public_ip
}