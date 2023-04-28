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
variable "components" {
default = ["frontend","mongodb","catalogue","redis","cart","user","shipping","payment","mysql","dispatch"]
}
resource "aws_instance" "frontend" {
count = length(var.components)
  ami           = data.aws_ami.centos.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.selected.id]

  tags = {
    Name = var.components[count.index]
  }
  }
  output "frontend" {
  value = aws_instance.frontend.public_ip
  }
#   resource "aws_route53_record" "var.components[count.index]" {
#     zone_id = "Z0941133DH3UYAXI04QH"
#     name    = "frontend-dev.anushadevopsb72.online"
#     type    = "A"
#     ttl     = 30
#     records = [aws_instance.var.components[count.index].private_ip]
#   }
#   resource "aws_instance" "mongodb" {
#     ami           = data.aws_ami.centos.image_id
#     instance_type = "var.instancetype"
#     vpc_security_group_ids = [data.aws_security_group.selected.id]
#
#     tags = {
#       Name = "mongodb"
#     }
#     }
#     resource "aws_route53_record" "mongodb" {
#         zone_id = "Z0941133DH3UYAXI04QH"
#         name    = "mongodb-dev.anushadevopsb72.online"
#         type    = "A"
#         ttl     = 30
#         records = [aws_instance.mongodb.private_ip]
#       }
#   resource "aws_instance" "catalogue" {
#      ami           = data.aws_ami.centos.image_id
#      instance_type = "var.instancetype"
#
#      tags = {
#        Name = "catalogue"
#      }
#      }
#      resource "aws_route53_record" "catalogue" {
#              zone_id = "Z0941133DH3UYAXI04QH"
#              name    = "catalogue-dev.anushadevopsb72.online"
#              type    = "A"
#              ttl     = 30
#              records = [aws_instance.catalogue.private_ip]
#            }
#    resource "aws_instance" "redis" {
#       ami           = data.aws_ami.centos.image_id
#       instance_type = "var.instancetype"
#
#       tags = {
#         Name = "redis"
#       }
#       }
#       resource "aws_route53_record" "redis" {
#                    zone_id = "Z0941133DH3UYAXI04QH"
#                    name    = "redis-dev.anushadevopsb72.online"
#                    type    = "A"
#                    ttl     = 30
#                    records = [aws_instance.redis.private_ip]
#                  }
#     resource "aws_instance" "user" {
#        ami           = data.aws_ami.centos.image_id
#        instance_type = "var.instancetype"
#
#        tags = {
#          Name = "user"
#        }
#        }
#        resource "aws_route53_record" "user" {
#                           zone_id = "Z0941133DH3UYAXI04QH"
#                           name    = "user-dev.anushadevopsb72.online"
#                           type    = "A"
#                           ttl     = 30
#                           records = [aws_instance.user.private_ip]
#                         }
#    resource "aws_instance" "cart" {
#       ami           = data.aws_ami.centos.image_id
#       instance_type = "var.instancetype"
#
#       tags = {
#         Name = "cart"
#       }
#       }
#       resource "aws_route53_record" "cart" {
#                                 zone_id = "Z0941133DH3UYAXI04QH"
#                                 name    = "cart-dev.anushadevopsb72.online"
#                                 type    = "A"
#                                 ttl     = 30
#                                 records = [aws_instance.cart.private_ip]
#                               }
#    resource "aws_instance" "mysql" {
#       ami           = data.aws_ami.centos.image_id
#       instance_type = "var.instancetype"
#
#       tags = {
#         Name = "mysql"
#       }
#       }
#        resource "aws_route53_record" "mysql" {
#                                 zone_id = "Z0941133DH3UYAXI04QH"
#                                 name    = "mysql-dev.anushadevopsb72.online"
#                                 type    = "A"
#                                 ttl     = 30
#                                 records = [aws_instance.mysql.private_ip]
#                               }
#     resource "aws_instance" "shipping" {
#        ami           = data.aws_ami.centos.image_id
#        instance_type = "var.instancetype"
#
#        tags = {
#          Name = "shipping"
#        }
#        }
#        resource "aws_route53_record" "shipping" {
#                                        zone_id = "Z0941133DH3UYAXI04QH"
#                                        name    = "shipping-dev.anushadevopsb72.online"
#                                        type    = "A"
#                                        ttl     = 30
#                                        records = [aws_instance.shipping.private_ip]
#                                      }
#        resource "aws_instance" "rabbitmq" {
#              ami           = data.aws_ami.centos.image_id
#              instance_type = "var.instancetype"
#
#              tags = {
#                Name = "rabbitmq"
#              }
#              }
#               resource "aws_route53_record" "rabbitmq" {
#                      zone_id = "Z0941133DH3UYAXI04QH"
#                      name    = "rabbitmq-dev.anushadevopsb72.online"
#                      type    = "A"
#                      ttl     = 30
#                      records = [aws_instance.rabbitmq.private_ip]
#                    }
#            resource "aws_instance" "payment" {
#               ami           = data.aws_ami.centos.image_id
#               instance_type = "var.instancetype"
#
#               tags = {
#                 Name = "payment"
#               }
#               }
#                resource "aws_route53_record" "payment" {
#                       zone_id = "Z0941133DH3UYAXI04QH"
#                       name    = "payment-dev.anushadevopsb72.online"
#                       type    = "A"
#                       ttl     = 30
#                       records = [aws_instance.payment.private_ip]
#                     }
#               resource "aws_instance" "dispatch" {
#                             ami           = data.aws_ami.centos.image_id
#                             instance_type = "var.instancetype"
#
#                             tags = {
#                               Name = "dispatch"
#                             }
#                             }
#                              resource "aws_route53_record" "dispatch" {
#                                     zone_id = "Z0941133DH3UYAXI04QH"
#                                     name    = "dispatch-dev.anushadevopsb72.online"
#                                     type    = "A"
#                                     ttl     = 30
#                                     records = [aws_instance.dispatch.private_ip]
#                                   }

