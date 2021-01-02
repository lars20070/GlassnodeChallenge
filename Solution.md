## code documentation

The code consists of two parts. `init.sql` is called during startup of the Postgres database and constructs a table `fees` containing the hourly ETH fees from the existing tables `contracts` and `transactions`. The second part consists of a Golang code snippet `main.go` which serves the content of the `fees` table as JSON.

| File | Description |
|------|-------------|
| init.sql | SQL script constructing the table `fees` |
| main.go  | Golang code for the REST API |
| Dockerfile | Docker container for Golang REST API |
| docker-compose.yaml | defines the `glassnode_database` and `glassnode_server` containers |

<br />

## installation

Run the docker compose up command in the home directory and visit `localhost:8080` in your browser. 

```
docker-compose up -d
curl localhost:8080
```