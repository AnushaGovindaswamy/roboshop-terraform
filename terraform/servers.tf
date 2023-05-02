data "aws_ami" "centos"{
  owners           = ["973714476881"]

  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice"
}
variable "instance_type2"{
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
default = ["frontend1","mongodb1","dispatch1"]
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
  for_each               = var.components
  ami                    = data.aws_ami.centos.image_id
  instance_type          = each.value["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = each.value["name"]
  }
}


resource "aws_route53_record" "records" {
  for_each               = var.components
  zone_id = "Z03986262CQPCHNJNZM9L"
  name    = "${each.value["name"]}-dev.rdevopsb72.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}

  resource "aws_instance" "instance2" {
  count =length(var.components2)
    ami           = data.aws_ami.centos.image_id
    instance_type = "var.instancetype2"
    vpc_security_group_ids = [data.aws_security_group.selected.id]

    tags = {
      Name = var.components2[count.index]
    }
    }


