FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server fail2ban iproute2 iptables vim net-tools curl && \
    rm -rf /var/lib/apt/lists/*

# Create ssh user
RUN useradd -m demo && echo 'demo:demo123' | chpasswd

# Configure SSHD
# RUN mkdir /var/run/sshd
COPY sshd_config /etc/ssh/sshd_config

# Fail2Ban configuration directory will be mounted; provide base jail.local that we can override
COPY fail2ban/jail.local /etc/fail2ban/jail.local
COPY fail2ban/filter.d/sshd.conf /etc/fail2ban/filter.d/sshd.conf

EXPOSE 22

# Supervising both sshd and fail2ban via simple script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
