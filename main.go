package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	_ "github.com/lib/pq"
)

// Fee is combines unix timestamp 't' and hourly ETH fees 'v'.
type Fee struct {
	T string `json:"t"`
	V string `json:"v"`
}

const (
	host     = "glassnode_database"
	port     = 5432
	user     = "test"
	password = "test"
	dbname   = "eth"
)

// OpenConnection opens the connection to the 'eth' database.
func OpenConnection() *sql.DB {
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)

	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}

	err = db.Ping()
	if err != nil {
		panic(err)
	}

	return db
}

// GETHandler exports the entire 'fees' table.
func GETHandler(w http.ResponseWriter, r *http.Request) {
	db := OpenConnection()

	rows, err := db.Query("SELECT * FROM fees")
	if err != nil {
		log.Fatal(err)
	}

	var feelist []Fee

	for rows.Next() {
		var fee Fee
		rows.Scan(&fee.T, &fee.V)
		feelist = append(feelist, fee)
	}

	feelistBytes, _ := json.MarshalIndent(feelist, "", "\t")

	w.Header().Set("Content-Type", "application/json")
	w.Write(feelistBytes)

	defer rows.Close()
	defer db.Close()
}

func main() {
	http.HandleFunc("/", GETHandler)

	log.Fatal(http.ListenAndServe(":8080", nil))
}
