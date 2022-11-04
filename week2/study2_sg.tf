resource "aws_security_group" "ersia_sg" {                  
  vpc_id      = aws_vpc.ersia_vpc.id                        
  name        = "T101 SG"                                   
  description = "T101 Study SG"                             
}                                                           
                                                            
resource "aws_security_group_rule" "ersia_sginbound" {      
  type              = "ingress"                             
  from_port         = 0                                     
  to_port           = 80                                    
  protocol          = "tcp"                                 
  cidr_blocks       = ["0.0.0.0/0"]                         
  security_group_id = aws_security_group.ersia_sg.id        
}                                                           
                                                            
resource "aws_security_group_rule" "ersia_sgoutbound" {     
  type              = "egress"                              
  from_port         = 0                                     
  to_port           = 0                                     
  protocol          = "-1"                                  
  cidr_blocks       = ["0.0.0.0/0"]                         
  security_group_id = aws_security_group.ersia_sg.id        
}                                                           
