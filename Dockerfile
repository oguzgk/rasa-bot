FROM rasa/rasa:2.8.1-full

WORKDIR /app

COPY . /app

# Memory optimizasyonu için environment variables
ENV RASA_TELEMETRY_ENABLED=false
ENV PORT=10000
ENV PYTHONPATH=/app
ENV MALLOC_TRIM_THRESHOLD_=100000
ENV RASA_MODELSERVER_WORKERS=1
ENV RASA_CORE_WORKERS=1
ENV PYTHONUNBUFFERED=1
ENV RASA_MEMORY_LIMIT=450m

# Rasa ve Actions server portları
EXPOSE 10000 5055

# Gereksiz dosyaları temizle ve pip cache'i temizle
USER root
RUN rm -rf /root/.cache/pip || true && \
    rm -rf /tmp/* || true && \
    rm -rf /var/cache/apt/* || true

# actions bağımlılıklarını minimal şekilde kur
RUN if [ -f "actions/requirements.txt" ]; then pip install --no-cache-dir -r actions/requirements.txt --no-deps; fi

# Non-root kullanıcıya geç
USER 1001

COPY start.sh /app/start.sh
ENTRYPOINT []
CMD ["bash", "/app/start.sh"]