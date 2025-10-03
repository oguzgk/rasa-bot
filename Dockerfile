# Rasa 2.8.1 (full) kullanıyoruz
FROM rasa/rasa:3.6.6-full

WORKDIR /app

# Kopyala
COPY . /app

# actions bağımlılıklarını kur
RUN if [ -f "actions/requirements.txt" ]; then pip install --no-cache-dir -r actions/requirements.txt; fi

# start script kopyala
COPY start.sh /app/start.sh

# Render default port
ENV PORT=10000

EXPOSE 10000 5055

# Önemli: önce entrypoint'i sıfırla
ENTRYPOINT []

# Artık gerçekten bash ile çalışacak
CMD ["bash", "/app/start.sh"]
