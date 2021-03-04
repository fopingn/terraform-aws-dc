# --- compute/main.tf ---

data "aws_ami" "windows" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["801119661308"]
}

resource "random_id" "ad_node_id" {
  byte_length = 2
  count       = var.instance_count
}


resource "aws_instance" "ad_node" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.windows.id

  tags = {
    Name = "ad_node-${random_id.ad_node_id[count.index].dec}"
  }

  key_name               = var.key_name
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnets[count.index]
  user_data              = var.user_data

  root_block_device {
    volume_size = var.vol_size
  }
}
