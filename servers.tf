
resource "aws_instance" "instance" {
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = each.value["name"]
  }
}

resource "null_resource" "provisioner" {
depends_on = [aws_instance.instance,aws_route53_record.records]
for_each=var.components

  connection {
    type     = "ssh"
          user     = "centos"
          password = "DevOps321"
          host     = aws_instance.instance[each.value["name"]].private_ip
  }

  provisioner "remote-exec" {
  inline = [
      "rm -rf roboshop-shell",
      "https://github.com/AnushaGovindaswamy/roboshop-shell.git",
      "cd roboshop-shell",
      "sudo bash ${each.value["name"]}.sh ${lookup(each.value,"password","null")}",

      ]
  }
}

resource "aws_route53_record" "records" {
  for_each= var.components
  zone_id = "Z0941133DH3UYAXI04QH"
  name    = "${each.value["name"]}-dev.anushadevopsb72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}




