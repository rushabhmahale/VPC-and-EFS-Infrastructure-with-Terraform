#provider
provider "aws" {
region = "ap-south-1"
profile = "Awsadmin"
}

#vpc 
resource "aws_vpc" "ppsvpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ppsvpc"
  }
}

#public subnet 
resource "aws_subnet" "ppspublic" {
  vpc_id     = "${aws_vpc.ppsvpc.id}"
  cidr_block = "192.168.0.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "ppspublic"
  }
}

#private subnet
resource "aws_subnet" "ppsprivate" {
  vpc_id     = "${aws_vpc.ppsvpc.id}"
  cidr_block = "192.168.1.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "ppsprivate"
  }
}

#internet gate way
resource "aws_internet_gateway" "ppsgw" {
  vpc_id = "${aws_vpc.ppsvpc.id}"

  tags = {
    Name = "ppsgw"
  }
}

#aws router 
resource "aws_route_table" "ppspublictable" {
  vpc_id = aws_vpc.ppsvpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ppsgw.id
  }


  tags = {
    Name = "ppstable"
  }
}
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.ppspublic.id
  route_table_id = aws_route_table.ppspublictable.id
}

resource "aws_security_group" "ppsSGwp" {
  name        = "My Wordpress Security Group"
  description = "HTTP , SSH , ICMP"
  vpc_id      =  "${aws_vpc.ppsvpc.id}"


  ingress {
    description = "HTTP Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH Port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    description = "MYSQL Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =  ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "ppssecuritygroup"
  }
}




resource "aws_security_group" "ppsSGmysql" {
  name = "My MYSQL Security Group"
  description = "MYSQL Security Group"
  vpc_id = "${aws_vpc.ppsvpc.id}"
 
 ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.ppsSGwp.id]
  }


 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags ={
    
    Name= "ppsmysql"
  }
}

#creating NAT getway
resource "aws_eip" "ppseip" {
  vpc = true
}

resource "aws_nat_gateway" "ppsnatg" {
  allocation_id = aws_eip.ppseip.id
  subnet_id = aws_subnet.ppspublic.id
  depends_on = [aws_internet_gateway.ppsgw]
  
  tags = {
   Name = "ppsnatg"
 }
}

resource "aws_route_table" "ppsprivatetable" {
  vpc_id = aws_vpc.ppsvpc.id
  route {
     cidr_block = "0.0.0.0/0"
     nat_gateway_id = aws_nat_gateway.ppsnatg.id
  }
  tags = {
    Name = "ppsprivatetable"
 }
}

resource "aws_route_table_association" "rta_subnet_private" {
   subnet_id = aws_subnet.ppsprivate.id
   route_table_id = aws_route_table.ppsprivatetable.id
  }

#creating key variable
variable "enter_ur_key_name" {
type = string
default = "awskey"
}

#launcing wordpress AMI 
resource "aws_instance" "ppswp" {
  ami           = "ami-000cbce3e1b899ebd"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.ppspublic.id
  vpc_security_group_ids = [aws_security_group.ppsSGwp.id]
  key_name = var.enter_ur_key_name
  availability_zone = "ap-south-1a"


  tags = {
    Name = "rsmwp"
  }
}

#launching mysql AMI
resource "aws_instance" "ppsmysql" {
  ami           = "ami-08706cb5f68222d09"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.ppsprivate.id}"
  vpc_security_group_ids = [aws_security_group.ppsSGmysql.id]
  key_name = var.enter_ur_key_name
  availability_zone = "ap-south-1b"
 tags ={
    
    Name= "rsmmysql"
  }
}

