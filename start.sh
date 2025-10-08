#!/bin/bash
set -e

# Temporary directories with correct permissions
mkdir -p /tmp/matplotlib && chmod 777 /tmp/matplotlib
mkdir -p /tmp/rasa && chmod 777 /tmp/rasa

# Cleanup any previous processes
pkill -f "rasa" || true

# Start with minimal resources
if [ -d "./actions" ] && [ -f "./actions/actions.py" ]; then
  echo "Starting actions server on port 5055..."
  rasa run actions --port 5055 --actions actions --debug &
  sleep 5
fi

# Start Rasa with minimal resources
echo "Starting Rasa server on port ${PORT}..."
rasa run \
  --enable-api \
  --cors "*" \
  --port ${PORT} \
  --endpoints endpoints.yml \
  --debug \
  --log-file /tmp/rasa/rasa.log
