FROM debian:stable-slim
RUN apt-get update && apt-get install -y --no-install-recommends openssh-client bash iputils-ping vim && rm -rf /var/lib/apt/lists/*
WORKDIR /root
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
