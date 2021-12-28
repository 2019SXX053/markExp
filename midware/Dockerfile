FROM python:3

RUN apt-get update && apt-get install -y default-mysql-client-core iputils-ping net-tools vim

RUN mkdir /midware

COPY requirements.txt /midware/
COPY start.sh /midware/

WORKDIR /midware

RUN pip install -r /midware/requirements.txt

COPY expapp.py /midware/
ADD templates /midware/templates

CMD ./start.sh