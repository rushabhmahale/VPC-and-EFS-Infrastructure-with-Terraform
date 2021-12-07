# VPC-and-EFS-Infrastructure-with-Terraform

## Video link:- https://drive.google.com/file/d/1IeZ9m6oVYEHefNqJntTCs52zH5bkwpdw/view?usp=sharing

## Diagram:-

![terraform final module efs drawio](https://user-images.githubusercontent.com/63963025/144979970-75863704-1591-48a3-b1d2-fd55ae5194dd.png)


## Performing the following steps:

1. Write an Infrastructure as code using terraform, which automatically create a VPC.
2. In that VPC we have to create 2 subnets:
- public subnet [ Accessible for Public World! ]
- private subnet [ Restricted for Public World! ]
3. Create a public facing internet gateway for connect our VPC/Network to the internet world and attach this gateway to our VPC.
4. Create a routing table for Internet gateway so that instance can connect to outside world, update and associate it with public subnet.
5. Create a NAT gateway for connect our VPC/Network to the internet world and attach this gateway to our VPC in the public network
6. Update the routing table of the private subnet, so that to access the internet it uses the nat gateway created in the public subnet
7. Launch an ec2 instance which has Wordpress setup already having the security group allowing port 80 sothat our client can connect to our wordpress site. Also attach the key to instance for further login into it.
8. Launch an ec2 instance which has MYSQL setup already with security group allowing port 3306 in private subnet so that our wordpress vm can connect with the same. Also attach the key with the same.
Note: Wordpress instance has to be part of public subnet so that our client can connect our site.
mysql instance has to be part of private subnet so that outside world can’t connect to it.

## NOTE:- 
- <b>Wordpress instance has to be part of public subnet so that our client can connect our site.</b>
- <b>mysql instance has to be part of private subnet so that outside world can’t connect to it.</b>

<b>Also go to AWS go to EC2 service instance  than go to Network and security there is an option called key pair click on it create one new key pem format and Download that key paste that key in same directory where your code is running</b>
  
## Changes to do:
 <b><br>#creating key variable<br> 
<br>variable "enter_ur_key_name" { <-------------------------- any name<br> 
<br>type = string<br>
<br>default = "awskey" <------------------ your key name only dont use extention pem<br>  
  
}</b>

change key name - var.enter_your_key to xyz
![Screenshot (139)](https://user-images.githubusercontent.com/63963025/144970213-99b53b79-94f9-45f4-9f01-d3a9bc549e37.png)

## terraform init
![Screenshot (127)](https://user-images.githubusercontent.com/63963025/144970311-b40660f4-59e0-4829-8314-d3a0b5928ff5.png)

## terraform plan

![Screenshot (128)](https://user-images.githubusercontent.com/63963025/144970344-9faa3ab8-d3a8-4958-9af0-ca33f57657e5.png)

## terraform apply
![Screenshot (129)](https://user-images.githubusercontent.com/63963025/144970375-abb5f8e0-fab7-4e56-9ac9-63a0aa9218c3.png)

## EC2 Instance 

![vm](https://user-images.githubusercontent.com/63963025/144977391-4c502fb1-c191-4645-82b5-fc6c6076de0b.png)

## VPC
![vpc](https://user-images.githubusercontent.com/63963025/144979705-5d710f2d-813f-4461-95b0-e6bb0269979d.png)


## Subnets
![subnets](https://user-images.githubusercontent.com/63963025/144979380-2a48c95b-e49b-4a78-881d-7248603f1bc1.png)


## Security group

![SG](https://user-images.githubusercontent.com/63963025/144979079-185a9711-df71-45cd-8a5f-fe605413bdb8.png)

## Elastic IP
![elastic ip](https://user-images.githubusercontent.com/63963025/144979219-7364852d-0826-412f-b39f-c14f40d6026c.png)

## Route table
![route table](https://user-images.githubusercontent.com/63963025/144979445-984a3b24-647e-49a2-ad5a-d755d8ebc695.png)

## Internet Gateway

![internet gateway](https://user-images.githubusercontent.com/63963025/144979484-3c3fcd93-caa4-4e8e-a77d-109d700edfd4.png)

## NAT Gateway
![NAT gateway](https://user-images.githubusercontent.com/63963025/144979568-302fb811-e4b1-4844-a22e-ab9e7527f8a2.png)
