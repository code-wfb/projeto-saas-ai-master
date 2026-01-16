#!/bin/bash

# ==========================================================
# SCRIPT DE SETUP - PROJETO AMA TECNOLOGIA (IA-COMMERCE)
# ==========================================================

# 1. Atualização do Sistema
echo "🔄 Atualizando repositórios..."
sudo apt-get update -y
sudo apt-get upgrade -y

# 2. Instalação de Ferramentas Essenciais e Multimídia (Preparação para Reels)
echo "🎬 Instalando FFmpeg e dependências de rede..."
sudo apt-get install -y \
    ffmpeg \
    curl \
    git \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    lsb-release

# 3. Instalação do Docker (O Motor do Projeto)
echo "🐳 Instalando Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# 4. Criar estrutura de persistência (Controle Orçamentário e de Dados)
# Isso garante que seus robôs fiquem salvos mesmo se a instância Spot cair
echo "📂 Criando pastas de dados..."
mkdir -p /home/ubuntu/n8n_data
sudo chown -R 1000:1000 /home/ubuntu/n8n_data

# 5. Subir o n8n via Docker
# Usamos a porta 5678 e mapeamos o volume para salvar tudo o que você fizer
echo "🚀 Subindo o n8n..."
docker run -d \
  --name n8n \
  --restart always \
  -p 5678:5678 \
  -v /home/ubuntu/n8n_data:/home/node/.n8n \
  -e N8N_SECURE_COOKIE=false \
  docker.n8n.io/n8nio/n8n

echo "✅ Setup Finalizado com Sucesso!"
echo "📍 O n8n estará disponível em cerca de 2 minutos na porta :5678"