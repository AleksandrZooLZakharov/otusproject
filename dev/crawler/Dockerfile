FROM python:3.6.0-alpine

COPY requirements.txt /requirements.txt
COPY requirements-test.txt /requirements-test.txt
RUN pip install --upgrade pip && pip install -r /requirements.txt -r /requirements-test.txt

ENV MONGO=34.76.155.153
ENV MONGO_PORT=27017
ENV RMQ_HOST=35.195.60.191
ENV RMQ_QUEUE=raq
ENV RMQ_USERNAME=user
ENV RMQ_PASSWORD=password
ENV CHECK_INTERVAL=30
ENV EXCLUDE_URLS=.*github.com

ENTRYPOINT [ "python", "-u", "crawler/crawler.py" ]
CMD [ "https://vitkhab.github.io/search_engine_test_site/" ]