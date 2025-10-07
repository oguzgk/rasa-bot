FROM rasa/rasa:2.8.1-full

WORKDIR /app

COPY . /app

# Memory optimizasyonu için environment variables
ENV RASA_TELEMETRY_ENABLED=false
ENV PORT=10000
ENV PYTHONPATH=/app
ENV MALLOC_TRIM_THRESHOLD_=100000

# Rasa ve Actions server portları
EXPOSE 10000 5055

# actions bağımlılıklarını kur
RUN if [ -f "actions/requirements.txt" ]; then pip install --no-cache-dir -r actions/requirements.txt; fi

# start script kopyala
COPY start.sh /app/start.sh

# Önemli: önce entrypoint'i sıfırla
ENTRYPOINT []

# Bellek optimizasyonu için --enable-api flag'i ekle
CMD ["bash", "/app/start.sh"]