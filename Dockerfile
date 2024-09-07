FROM golang:1.17-alpine
WORKDIR /src
RUN apk --no-cache add git
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/prometheus-ecs-discovery .
RUN ls -la

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=0 /bin/prometheus-ecs-discovery /bin/
WORKDIR /home
COPY . .
#RUN mv /home/aws /root/.aws
ENTRYPOINT ["prometheus-ecs-discovery"]
