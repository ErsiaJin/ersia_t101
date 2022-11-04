resource "aws_lb_listener_rule" "ersia_albrule" {             
  listener_arn = aws_lb_listener.ersia_http.arn              
  priority     = 100                                         
                                                             
  condition {                                                
    path_pattern {                                           
      values = ["*"]                                         
    }                                                        
  }                                                          
                                                             
  action {                                                   
    type             = "forward"                             
    target_group_arn = aws_lb_target_group.ersia_albtg.arn   
  }                                                          
}                                                            
                                                             
output "ersia_alb_dns2" {                                     
  value       = aws_lb.ersia_alb.dns_name                    
  description = "The DNS Address of the ALB"                 
}                                                            
