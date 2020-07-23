resource "aws_instance" "main" {
  ami = data.aws_ssm_parameter.amzn2_ami.value
  instance_type = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = "true"
  user_data                   = data.template_file.userdata.rendered
  key_name                    = "minecraft"
  tags = { Name = "minecraft" }
}

data aws_ssm_parameter amzn2_ami {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_eip" "main" {
  instance = aws_instance.main.id
  vpc      = true
  tags     = { Name = "minecraft" }
}

data "template_file" "userdata" {
  template = file("./userdata.sh")
}
