FROM ubuntu
RUN ln -fs /usr/share/zoneinfo/Asia/Irkutsk /etc/localtime
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip  \
    nginx uwsgi uwsgi-plugin-python3

COPY requirements.txt /lavaland/
RUN python3 -m pip install -r /lavaland/requirements.txt

RUN mkdir /etc/nginx/ssl
COPY ./ssl/* /etc/nginx/ssl/*
COPY nginx.conf /etc/nginx/nginx.conf
RUN systemclt start nginx

COPY uwsgi.ini /lavaland/
COPY app/ /lavaland/
CMD uwsgi --ini /lavaland/uwsgi.ini
