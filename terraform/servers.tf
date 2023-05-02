data "aws_ami" "centos"{
  owners           = ["973714476881"]

  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}
variable "instance_type"{
default = "t3.small"
}
 data "aws_security_group" "selected" {
 name ="allow-all"
 }
 output "securitygroup" {
 value = data.aws_security_group.selected.id
 }
output "aws_ami" {
value=data.aws_ami.centos.image_id
}
variable "components2" {
default = ["frontend","mongodb","catalogue","redis","cart","user","shipping","payment","mysql","rabbitmq","dispatch"]
}
variable "components" {
default = {
frontend ={
name = "frontend"
   instance_type = "t3.micro"
 }
 mongodb ={
 name = "mongodb"
    instance_type = "t3.micro"
  }
   catalogue ={
   name = "catalogue"
      instance_type ="t3.micro"
    }
     user ={
       name = "user"
          instance_type = "t3.micro"
        }
  cart ={
  name = "cart"
     instance_type = "t3.small"
   }
  mysql ={
  name = "mysql"
     instance_type = "t3.small"
   }
   shipping ={
     name = "shipping"
        instance_type = "t3.small"
      }
     rabbitmq ={
     name = "rabbitmq"
        instance_type = "t3.small"
      }
      payment ={
           name = "payment"
              instance_type = "t3.small"
            }
     dispatch ={
                name = "dispatch"
                   instance_type = "t3.small"
                 }




}

}
resource "aws_instance" "instance" {
for-each =var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = each.value["name"]
  }
  }
#   output "instancename" {
#   value = aws_instance.var.components[count.index].public_ip
#   }
  resource "aws_route53_record" "records" {
  for-each =var.components
    zone_id = "Z0941133DH3UYAXI04QH"
    name    = "${each.value["name"]}-dev.anushadevopsb72.online"
    type    = "A"
    ttl     = 30
    records = [aws_instance.instance[each.value["name"]].private_ip]
  }
  resource "aws_instance" "instance2" {
  count =length(var.components2)
    ami           = data.aws_ami.centos.image_id
    instance_type = "var.instancetype"
    vpc_security_group_ids = [data.aws_security_group.selected.id]

    tags = {
      Name = var.components2[count.index]
    }
    }
    resource "aws_route53_record" "records" {
     count =length(var.components2)
        zone_id = "Z0941133DH3UYAXI04QH"
        name    = " ${var.components2[count.index]}-dev.anushadevopsb72.online"
        type    = "A"
        ttl     = 30
        records = [aws_instance.var.components2[count.index].private_ip]
      }

