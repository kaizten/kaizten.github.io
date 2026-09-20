# Author: Kaizten Analytics S.L. (info@kaizten.com)

FROM python:3.11
LABEL maintainer="info@kaizten.com"

ARG XLSX_FILE
ARG SHEET_NAME
ARG JSON_FILE

ENV XLSX_FILE $XLSX_FILE
ENV SHEET_NAME $SHEET_NAME
ENV JSON_FILE $JSON_FILE

RUN apt-get update -y && apt-get install -y python3-pip python3-dev

COPY ./requirements.txt /requirements.txt

WORKDIR /

RUN pip3 install -r requirements.txt

COPY . /

ENTRYPOINT [ "python3" ]
CMD ["parser-vessel-scales.py", "-i", "${XLSX_FILE}" , "-s", "$SHEET_NAME", "-o", "$JSON_FILE"]