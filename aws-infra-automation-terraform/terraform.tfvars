region = "us-east-1"

cidr = "10.0.0.0/16"

subnets = {
  subnet1 = {
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "us-east-1a"
  }
  subnet2 = {
    cidr_block              = "10.0.1.0/24"
    availability_zone       = "us-east-1b"
  }
}

instances = {
  webserver1 = {
    ami           = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    user_data     = "userdata1.sh"
    subnet_key    = "subnet1"
  }
  webserver2 = {
    ami           = "ami-0261755bbcb8c4a84"
    instance_type = "t2.micro"
    user_data     = "userdata2.sh"
    subnet_key    = "subnet2"
  }
}
