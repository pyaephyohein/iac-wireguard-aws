resource "aws_security_group" "wireguard" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.wireguard.id

  ingress {
    description      = "allow all"
    from_port        = 0
    to_port          = 0
    protocol         = "all"
    cidr_blocks      = [aws_vpc.wireguard.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}