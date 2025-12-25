output "security_group_id" {
  value       = aws_security_group.web_sg.id
  description = "ID do Security Group para o Servidor Web"
}
