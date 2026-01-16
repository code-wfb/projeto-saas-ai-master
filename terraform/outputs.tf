output "instance_public_ip" {
  description = "IP Público do servidor n8n para acesso via navegador"
  value       = aws_instance.n8n_server.public_ip
}

output "n8n_url" {
  description = "URL de acesso direto ao painel do n8n"
  value       = "http://${aws_instance.n8n_server.public_ip}:5678"
}