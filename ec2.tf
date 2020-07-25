resource "aws_instance" "main" {
  ami = "ami-06ad9296e6cf1e3cf"
  instance_type = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = "true"
  user_data                   = data.template_file.userdata.rendered
  key_name                    = "minecraft"
  tags = { Name = "minecraft" }

  lifecycle {
    ignore_changes = ["user_data"]
  }
}

data "template_file" "userdata" {
  template = file("./userdata.sh")
}
