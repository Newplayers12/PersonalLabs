#!/bin/bash
set -euo pipefail

PROFILE_NAME=${F2B_PROFILE:-}
if [ -n "$PROFILE_NAME" ]; then
	SRC="/profiles/${PROFILE_NAME}.jail.local"
	if [ -f "$SRC" ]; then
		echo "Applying Fail2Ban profile: $PROFILE_NAME"
		cp "$SRC" /etc/fail2ban/jail.local
	else
		echo "Requested profile $PROFILE_NAME not found at $SRC; keeping existing jail.local" >&2
	fi
else
	echo "No F2B_PROFILE specified; using image default jail.local"
fi

# echo "Starting fail2ban..."
# service fail2ban start
echo "Starting sshd (foreground, logging to /var/log/auth.log)..."
/usr/sbin/sshd -D -e -E /var/log/auth.log # lưu ý chỗ này thôi á
sleep infinity
