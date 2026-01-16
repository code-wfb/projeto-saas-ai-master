provider "aws" {
  region = "us-east-1"
}

# Criar o Grupo de Segurança (Firewall)
resource "aws_security_group" "n8n_sg" {
  name        = "n8n-security-group"
  description = "Portas para n8n e SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5678
    to_port     = 5678
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Criar a Instância EC2 (Servidor Spot Econômico)
resource "aws_instance" "n8n_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS
  instance_type = "t3.small"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.n8n_sg.id]

  # Instalação automática do Docker e n8n
  user_data = file("scripts/setup.sh")

  tags = {
    Name = "n8n-ai-engine"
  }
}