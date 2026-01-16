#!/bin/bash
echo "🔍 Iniciando Verificação de Saúde do Sistema..."

# 1. Verificar Docker
if systemctl is-active --quiet docker; then
    echo "✅ Docker: Rodando"
else
    echo "❌ Docker: Parado"
fi

# 2. Verificar Container do n8n
if [ "$(docker ps -q -f name=n8n)" ]; then
    echo "✅ Container n8n: Ativo"
else
    echo "❌ Container n8n: Não encontrado"
fi

# 3. Verificar Porta 5678 (n8n)
if ss -tuln | grep -q ":5678"; then
    echo "✅ Porta 5678: Aberta"
else
    echo "❌ Porta 5678: Fechada"
fi

# 4. Saúde da CPU e Memória
echo "📊 Recursos do Sistema:"
free -h | grep -E "Mem|Total"
df -h / | tail -1 | awk '{print "💾 Disco em uso: " $5}'

echo "🏁 Verificação Concluída!"