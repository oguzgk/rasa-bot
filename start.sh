#!/bin/bash
set -e

# Eğer actions klasörü ve actions.py varsa actions server'ı arka planda başlat
if [ -d "./actions" ] && [ -f "./actions/actions.py" ]; then
  echo "Starting actions server on port 5055..."
  rasa run actions --port 5055 &
  # küçük bir bekleme ver (actions server'ın dinlemeye başlaması için)
  sleep 2
fi

# Rasa server'ı başlat (PORT env değişkenini kullanır)
echo "Starting Rasa server on port ${PORT}..."
rasa run --enable-api --cors "*" --port ${PORT} --endpoints endpoints.yml
