
resource "aws_instance" "wireguard" {
  ami           = "ami-055d15d9cfddf7bd3"
  instance_type = "t2.micro"
  key_name = var.ssh_key
  associate_public_ip_address = true
  tags = {
    "Name"= "wireguard"
  }
}
resource "local_file" "ansible_inventory" {
filename = "./ansible-wireguard/inventory"
content = <<EOF
[wireguard]
hostname=wireguard ansible_ssh_host=${aws_instance.wireguard.public_ip} ansible_user=ubuntu ansible_ssh_common_args='-o StrictHostKeyChecking=no'
ansible_python_interpreter = /usr/bin/python3
ssh_args = -o StrictHostKeyChecking=no -oCompression=yes
inventory = ./inventory
EOF
provisioner "local-exec" {command = "sleep 10 && ansible-playbook -i ./ansible-wireguard/inventory -v ./ansible-wireguard/run.yaml"}
}

  
