#!/bin/bash
set -e
if [ -z "${SSH_SERVER:-}" ]; then
  echo "Set SSH_SERVER env var (hostname or IP)." >&2
  sleep infinity
else
  echo "Container ready. Try: ssh demo@$SSH_SERVER"
  sleep infinity
fi
