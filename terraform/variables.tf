variable "key_name" {
  description = "Nome da chave .pem que você criou na AWS"
  type        = string
}

variable "email_alertas" {
  description = "E-mail para alertas (opcional por enquanto)"
  type        = string
  default     = ""
}