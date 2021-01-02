FROM golang:latest
RUN mkdir /app
COPY ./main.go /app/main.go
WORKDIR /app
RUN go get github.com/lib/pq
RUN go build -o main .
ENTRYPOINT /app/main