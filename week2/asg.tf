data "aws_ami" "ersia_amazonlinux2" {                                                
  most_recent = true                                                                
  filter {                                                                          
    name   = "owner-alias"                                                          
    values = ["amazon"]                                                             
  }                                                                                 
                                                                                    
  filter {                                                                          
    name   = "name"                                                                 
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]                                         
  }                                                                                 
                                                                                    
  owners = ["amazon"]                                                               
}                                                                                   
                                                                                    
resource "aws_launch_configuration" "ersia_lauchconfig" {                           
  name_prefix     = "t101-lauchconfig-"                                             
  image_id        = data.aws_ami.ersia_amazonlinux2.id                              
  instance_type   = "t2.micro"                                                      
  security_groups = [aws_security_group.ersia_sg.id]                                
  associate_public_ip_address = true                                                
                                                                                    
  user_data = "${file("ec2-userdata-web.tftpl")}"                                   
                                                                                    
  # Required when using a launch configuration with an auto scaling group.          
  lifecycle {                                                                       
    create_before_destroy = true                                                    
  }                                                                                 
}                                                                                   
                                                                                    
resource "aws_autoscaling_group" "ersia_asg" {                                      
  name                 = "ersia_asg"                                                
  launch_configuration = aws_launch_configuration.ersia_lauchconfig.name            
  vpc_zone_identifier  = [aws_subnet.ersia_subnet1.id, aws_subnet.ersia_subnet2.id] 
  min_size = 3                                                                      
  max_size = 10                                                                     
  health_check_type = "ELB"                                                         
  target_group_arns = [aws_lb_target_group.ersia_albtg.arn]                         
                                                                                    
  tag {                                                                             
    key                 = "Name"                                                    
    value               = "terraform-asg"                                           
    propagate_at_launch = true                                                      
  }                                                                                 
}                                                                                   
