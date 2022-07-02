FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8

RUN pip install \
    pydantic \
    python-multipart\
    aiofiles \
    fastapi \
    fastapi-contrib[jaegertracing] \
    uvicorn \
    minio \
    starlette-prometheus \
    requests \
    psycopg2 \
    aiohttp

WORKDIR /home/server

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .


ENV MODULE_NAME=api
ENV APP_MODULE=api:app
ENV WORKERS_PER_CORE=1
ENV PORT=8000


CMD uvicorn app:app --host 0.0.0.0 --port 8000
