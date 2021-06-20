FROM alpine:3.14
WORKDIR /app

RUN apk add git bash curl git
COPY run.sh ./

CMD ["bash", "/app/run.sh"]
