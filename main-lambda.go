package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/apex/gateway"
	"github.com/julienschmidt/httprouter"
)

const (
	serverPort = 9000
)

func main() {
	router := httprouter.New()
	router.Handler("GET", "/", http.HandlerFunc(HealthHandler))
	router.Handler("GET", "/healthz", http.HandlerFunc(HealthHandler))

	fmt.Printf("Lambda Server listening on port: %d\n", serverPort)
	log.Fatal(gateway.ListenAndServe(fmt.Sprintf(":%d", serverPort), router), nil)
}
