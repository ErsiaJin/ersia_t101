resource "aws_internet_gateway" "ersia_igw" { 
  vpc_id = aws_vpc.ersia_vpc.id               
                                              
  tags = {                                    
    Name = "t101-igw"                         
  }                                           
}                                             
