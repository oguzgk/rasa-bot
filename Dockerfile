# Rasa 2.8.1 (full) kullanıyoruz
FROM rasa/rasa:2.8.1-full

WORKDIR /app

# Kopyala
COPY . /app

# actions bağımlılıklarını kur
# (actions/requirements.txt yoksa komut hata versin diye '|| true' eklenebilir)
RUN if [ -f "actions/requirements.txt" ]; then pip install --no-cache-dir -r actions/requirements.txt; fi

# start script kopyala ve izni ver
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Port: Render default olarak PORT=10000 kullanıyor, ama bunu Render dashboard'da değiştirebilirsin.
ENV PORT=10000

# EXPOSE sadece dokümantasyon amaçlı; Render port yönlendirmeyi kendi yapıyor.
EXPOSE 10000 5055

CMD ["/app/start.sh"]
