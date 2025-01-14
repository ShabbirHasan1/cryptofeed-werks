FROM python:3.9-slim-buster

ARG POETRY_EXPORT
ARG PROJECT_ID
ARG BIGQUERY_LOCATION
ARG BIGQUERY_DATASET
ARG SENTRY_DSN

ENV PROJECT_ID $PROJECT_ID
ENV BIGQUERY_LOCATION $BIGQUERY_LOCATION
ENV BIGQUERY_DATASET $BIGQUERY_DATASET
ENV SENTRY_DSN $SENTRY_DSN

ADD cryptofeed_werks /cryptofeed_werks/
ADD main.py /

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && pip install --no-cache-dir $POETRY_EXPORT \
    && apt-get purge -y --auto-remove build-essential \
    && apt-get clean  \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/main.py"]
