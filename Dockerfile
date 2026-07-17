FROM alpine:3.19 AS patcher

WORKDIR /app/

RUN apk add --no-cache wget unzip

RUN wget https://f003.backblazeb2.com/file/lionzxy-static-files/ULTRAMINE_IMPACT_EMPTY_SERVER.zip -O ultramine.zip && \
    unzip ultramine.zip -d impact && \
    rm ultramine.zip

RUN wget https://f003.backblazeb2.com/file/lionzxy-static-files/IMPACT-1.0.2.2q-SERVER.zip -O impact.zip && \
    unzip impact.zip -d impact && \
    rm impact.zip

COPY server/ impact/

FROM eclipse-temurin:8-jre-jammy

WORKDIR /app/

ENV RCON_PORT=25575 RCON_PASSWORD=DEFAULT
COPY --from=itzg/rcon-cli:latest /rcon-cli /bin/

COPY --from=patcher /app/impact /app/
RUN chmod +x /app/startserver.sh

CMD /app/startserver.sh
