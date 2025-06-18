#!/bin/bash

echo "🧪 Тестирование gRPC API и метрик..."

# Проверяем, что сервис запущен
echo "📡 Проверяем доступность gRPC сервера..."
nc -z localhost 50052
if [ $? -eq 0 ]; then
    echo "✅ gRPC сервер доступен на порту 50052"
else
    echo "❌ gRPC сервер недоступен на порту 50052"
    exit 1
fi

# Проверяем метрики
echo "📊 Проверяем метрики..."
curl -s http://localhost:9090/metrics | grep -E "(dish_|grpc_)" || echo "Кастомные метрики пока не появились (это нормально, если не было gRPC вызовов)"

echo ""
echo "🔍 Для тестирования API используйте:"
echo "   grpcurl -plaintext localhost:50052 list"
echo "   grpcurl -plaintext localhost:50052 list v1.MenuService"
echo ""
echo "📈 Метрики доступны по адресу:"
echo "   http://localhost:9090/metrics" 