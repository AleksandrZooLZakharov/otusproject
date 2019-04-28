FROM digitalgenius/alpine-python3-pg:latest

RUN git clone https://github.com/express42/search_engine_ui.git && cd search_engine_ui && pip install -r requirements.txt

ENV MONGO=104.155.43.123
ENV MONGO_PORT=27017

WORKDIR /search_engine_ui/ui

CMD FLASK_APP=ui.py gunicorn ui:app -b 0.0.0.0