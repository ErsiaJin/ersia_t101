resource "aws_route_table" "ersia_rt" {                          
  vpc_id = aws_vpc.ersia_vpc.id                                  
                                                                 
  tags = {                                                       
    Name = "t101-rt"                                             
  }                                                              
}                                                                
                                                                 
resource "aws_route_table_association" "ersia_rt_association1" { 
  subnet_id      = aws_subnet.ersia_subnet1.id                   
  route_table_id = aws_route_table.ersia_rt.id                   
}                                                                
                                                                 
resource "aws_route_table_association" "ersia_rt_association2" { 
  subnet_id      = aws_subnet.ersia_subnet2.id                   
  route_table_id = aws_route_table.ersia_rt.id                   
}                                                                
                                                                 
resource "aws_route" "ersia_defaultroute" {                      
  route_table_id         = aws_route_table.ersia_rt.id           
  destination_cidr_block = "0.0.0.0/0"                           
  gateway_id             = aws_internet_gateway.ersia_igw.id     
}                                                                
