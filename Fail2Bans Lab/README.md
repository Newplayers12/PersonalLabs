# Fail2Ban Lab (SSH Client/Server)

This lab spins up two containers:
- `ssh-server`: OpenSSH server with Fail2Ban.
- `ssh-client`: Simple container with `ssh` client to test bans.

## Profiles
Profiles live in `fail2ban-profiles/` (all use `backend = auto` and monitor `/var/log/auth.log` which sshd now writes directly using `sshd -E /var/log/auth.log`):
- `short-ban.jail.local`: 30s ban after 3 failures in 60s.
- `medium-ban.jail.local`: 1h ban after 3 failures in 5m.
- `long-ban.jail.local`: 24h ban after 3 failures in 10m.
- `forever-ban.jail.local`: Permanent ban (`bantime = -1`).

## Selecting a profile
Set the environment variable `F2B_PROFILE` on the server service (compose file) to one of: `short-ban`, `medium-ban`, `long-ban`, `forever-ban`.
The `start.sh` script copies the matching `*.jail.local` file from `/profiles` into `/etc/fail2ban/jail.local` at container start.

## Usage
Build and start:
```powershell
docker compose up --build -d
```

Check server logs:
```powershell
docker logs -f f2b_ssh_server
```

Enter client and attempt wrong password to trigger ban:
```powershell
docker exec -it f2b_ssh_client bash
ssh demo@ssh-server   # password is demo123 (use wrong first)
```

List Fail2Ban jails & status:
```powershell
docker exec -it f2b_ssh_server fail2ban-client status
```

See specific jail:
```powershell
docker exec -it f2b_ssh_server fail2ban-client status sshd
```

Unban an IP:
```powershell
docker exec -it f2b_ssh_server fail2ban-client set sshd unbanip <IP>
```

Change profile (example to forever-ban):
```powershell
docker compose stop ssh-server
docker compose run --rm -e F2B_PROFILE=forever-ban ssh-server true
docker compose up -d ssh-server
```
Simpler: edit `docker-compose.yml` F2B_PROFILE and recreate the service.

## TODO
- Modify entrypoint to apply selected profile before starting Fail2Ban.
- Optionally add docker healthcheck.
