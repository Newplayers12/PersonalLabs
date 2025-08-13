# Rsync Lab: Non-Authenticated Pull with IP/Container Restrictions

This lab demonstrates how to configure an `rsync` server in Docker to allow **read-only (pull) access** to shared data, with restrictions on which clients (by IP or container) can access the data. **Push (write) operations are not allowed** due to the server configuration.

## Lab Structure

- **rsync-server**: Runs the rsync daemon with a specified configuration file.
- **client1** and **client2**: Two client containers, each with rsync installed.
- **Shared Data**: Located in `server/data/hello.txt` and exposed via the rsync server.

## Scenarios

### Scenario 1: Only Specific Client Allowed
- The server uses `rsyncd_scenario1.conf`.
- Only the specified client (by hostname/IP) is allowed to pull data.
- Example config:
	```ini
	[shared]
			path = /data
			read only = yes
			hosts allow = client1
	```

### Scenario 2: Deny All Except One
- The server uses `rsyncd_scenario2.conf`.
- Only `client2` is allowed; all others are denied.
- Example config:
	```ini
	[shared]
			path = /data
			read only = yes
			hosts allow = client2
			hosts deny = *
	```

## Key Points
- **No Authentication**: No password or user authentication is required for pulling data.
- **Read-Only**: The `read only = yes` setting ensures clients cannot push (write) data to the server.
- **Access Control**: The `hosts allow` and `hosts deny` directives restrict which containers can pull data.
- **No Push Allowed**: Write operations are not permitted by configuration.

## Usage
1. Start the lab with Docker Compose:
	 ```sh
	 docker-compose up -d
	 ```
2. To test pulling data from an allowed client:
	 ```sh
	 docker exec -it client1 sh
     ```

     ```sh
     rsync rsync://server/shared/hello.txt /tmp/
	 ```
3. Attempting to push or pulling from a denied client will fail.

## References
- [rsyncd.conf documentation](https://download.samba.org/pub/rsync/rsyncd.conf.html)
