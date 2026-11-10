provider "aws" {
  region = "us-east-1"
}

# 1. Grupo de Seguridad para Windows
resource "aws_security_group" "sg_windows" {
  name        = "tarea4-windows"
  description = "Permitir Escritorio Remoto (RDP) y HTTP"

  # Puerto para conectarse a Windows
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Puerto Web
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Salida total a internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Creación de la Instancia Windows
resource "aws_instance" "servidor_windows" {
  
  ami           = "ami-0b5f645abc199e666" 
  
  instance_type = "t3.micro" 
  key_name      = "segunda-llave"  
  
  vpc_security_group_ids = [aws_security_group.sg_windows.id]

  tags = {
    Name = "Windows-Tarea4" 
  }
}

# 3. Mostrar la IP Pública en la consola
output "ip_publica_windows" {
  value = aws_instance.servidor_windows.public_ip
}