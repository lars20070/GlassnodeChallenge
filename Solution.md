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

<br />

## solution

Unix timestamps and corresponding total hourly ETH fees.

```
[
	{
		"t": "1599436800",
		"v": "17781937815.7073"
	},
	{
		"t": "1599440400",
		"v": "25796173158.8859"
	},
	{
		"t": "1599444000",
		"v": "34821055861.441"
	},
	{
		"t": "1599447600",
		"v": "29814493424.4049"
	},
	{
		"t": "1599451200",
		"v": "27821774201.374"
	},
	{
		"t": "1599454800",
		"v": "25575311595.6576"
	},
	{
		"t": "1599458400",
		"v": "33138772595.6814"
	},
	{
		"t": "1599462000",
		"v": "35671504748.4052"
	},
	{
		"t": "1599465600",
		"v": "29861742077.138"
	},
	{
		"t": "1599469200",
		"v": "31870528305.5473"
	},
	{
		"t": "1599472800",
		"v": "29492777739.8214"
	},
	{
		"t": "1599476400",
		"v": "28476895183.2161"
	},
	{
		"t": "1599480000",
		"v": "31458479835.443"
	},
	{
		"t": "1599483600",
		"v": "36114881483.4539"
	},
	{
		"t": "1599487200",
		"v": "39990571952.8013"
	},
	{
		"t": "1599490800",
		"v": "32351461366.0727"
	},
	{
		"t": "1599494400",
		"v": "35702769826.0357"
	},
	{
		"t": "1599498000",
		"v": "28225350833.5762"
	},
	{
		"t": "1599501600",
		"v": "23619974534.4661"
	},
	{
		"t": "1599505200",
		"v": "20792555662.4104"
	},
	{
		"t": "1599508800",
		"v": "20324756156.8389"
	},
	{
		"t": "1599512400",
		"v": "18641503209.0896"
	},
	{
		"t": "1599516000",
		"v": "16778240397.6198"
	},
	{
		"t": "1599519600",
		"v": "17399949324.596"
	}
]
```