FROM nvidia/cuda:11.7.0-cudnn8-runtime-ubuntu22.04

WORKDIR /app

# Installs Python 3.10 which is what we need
RUN apt-get update && apt-get install -y python3 python3-pip python3-wheel python3-setuptools

COPY requirements.txt .
RUN pip3 install -r requirements.txt

ARG TEXT_MODEL_NAME
ARG CLIP_MODEL_NAME
ARG OPEN_CLIP_MODEL_NAME
ARG OPEN_CLIP_PRETRAINED
COPY download.py .
RUN ./download.py

COPY . .

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["uvicorn app:app --host 0.0.0.0 --port 8080"]