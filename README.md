# VPC-and-EFS-Infrastructure-with-Terraform

## Diagram 

![aws terraform vpc sql wordpress](https://user-images.githubusercontent.com/63963025/144967814-e0f137a5-c242-438f-827b-7b3c11b1f581.png)

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

<b>Also go to AWS go to EC2 service instance  than go to <b>Network and security there is an option called key pair click on it create one new key pem format and Download that key paste that key in same directory where your code is running<b>
  
## Changes to do:
  <br>#creating key variable<br> 
<br>variable "enter_ur_key_name" { <-------------------------- any name<br> 
<br>type = string<br>
<br>default = "awskey" <------------------ your key name only dont use extention pem<br>  
  
change key name - var.enter_your_key
}
