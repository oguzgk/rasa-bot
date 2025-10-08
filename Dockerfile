FROM rasa/rasa:2.8.1-full

WORKDIR /app

COPY . /app

# Extreme memory optimization
ENV RASA_TELEMETRY_ENABLED=false
ENV PORT=10000
ENV PYTHONPATH=/app
ENV MALLOC_TRIM_THRESHOLD_=100000
ENV RASA_MODELSERVER_WORKERS=1
ENV RASA_CORE_WORKERS=1
ENV PYTHONUNBUFFERED=1
ENV RASA_MEM_PATTERN=tensorflow
ENV TF_NUM_THREADS=1
ENV MKL_NUM_THREADS=1
ENV GUNICORN_WORKERS=1
ENV GUNICORN_THREADS=1
ENV MPLCONFIGDIR=/tmp/matplotlib
ENV TF_FORCE_GPU_ALLOW_GROWTH=true
ENV TF_CPP_MIN_LOG_LEVEL=2
ENV TOKENIZERS_PARALLELISM=false
ENV OMP_NUM_THREADS=1
ENV PYTORCH_NO_CUDA_MEMORY_CACHING=1
ENV TF_ENABLE_ONEDNN_OPTS=0
ENV MALLOC_ARENA_MAX=2
ENV PYTHONOPTIMIZE=2
ENV RASA_TELEMETRY_DEBUG=false
ENV SANIC_NO_UVLOOP=true
ENV RASA_PRODUCTION=1
ENV MODEL_CACHE_SIZE=100
ENV MAX_NUMBER_OF_PREDICTIONS=1
# Server configuration
ENV RASA_SERVER_HOST="0.0.0.0"
ENV RASA_SERVER_PORT="${PORT}"

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