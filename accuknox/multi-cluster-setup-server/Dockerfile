FROM python:3.9.20-alpine3.20 AS base
ENV BUILDWORKDIR=/home/app
WORKDIR $BUILDWORKDIR
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1
RUN mkdir -p $BUILDWORKDIR && \
    addgroup -S -g 101 app && adduser -S -u 101 app -G app && \
    chown -R app:app $BUILDWORKDIR

FROM base AS build
WORKDIR $BUILDWORKDIR
COPY --chown=app:app ./requirements.txt .
RUN pip install --upgrade pip && \
    pip wheel --no-cache-dir --no-deps --wheel-dir $BUILDWORKDIR/wheels -r requirements.txt
USER app

FROM base AS final
WORKDIR $BUILDWORKDIR
COPY --chown=app:app --from=build $BUILDWORKDIR/wheels ./wheels
RUN pip install --upgrade pip && \
    pip install  --no-cache-dir --no-cache ./wheels/* && rm -rf ./wheels
RUN pip install uvicorn==0.30.6 
COPY --chown=app:app main.py utils.py . 
EXPOSE 5000
USER app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000","--ssl-keyfile=/certs/private.key", "--ssl-certfile=/certs/certificate.crt"]