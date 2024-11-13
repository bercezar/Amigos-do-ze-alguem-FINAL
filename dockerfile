# Use uma imagem oficial do Python
FROM python:3.12.15

# Defina o diretório de trabalho
WORKDIR /app

# Copie o arquivo requirements.txt e instale as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copie todos os arquivos do projeto para o contêiner
COPY . .

# Defina as variáveis de ambiente necessárias
ENV PYTHONUNBUFFERED=1
ENV PORT=8000

# Colete arquivos estáticos e aplique migrações (opcional)
RUN python manage.py collectstatic --noinput
RUN python manage.py migrate

# Exponha a porta para o Railway
EXPOSE $PORT

# Comando para iniciar o servidor
CMD ["gunicorn", "app.wsgi:application", "--bind", "0.0.0.0:$PORT"]
