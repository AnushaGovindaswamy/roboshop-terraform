components={

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
env = "dev"