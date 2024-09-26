FROM python:3.9.20-alpine3.20
WORKDIR /webhook
COPY requirements.txt /webhook
COPY main.py /webhook
COPY certs ./certs
RUN pip install --no-cache-dir --upgrade -r /webhook/requirements.txt
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000","--ssl-keyfile=certs/private.key", "--ssl-certfile=certs/certificate.crt"]