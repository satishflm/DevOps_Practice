resource "aws_instance" "one" {
tags = {
Name = var.iname
}
ami = var.ami_id
instance_type = var.itype
count = var.icount

vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "Hello, World!" > /var/www/html/index.html
  EOF
}
