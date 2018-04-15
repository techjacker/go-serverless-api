package main

import (
	"fmt"
	"net/http"

	"github.com/julienschmidt/httprouter"
)

const (
	serverPort = 8000
)

func main() {
	router := httprouter.New()
	router.Handler("GET", "/", http.HandlerFunc(HealthHandler))
	router.Handler("GET", "/healthz", http.HandlerFunc(HealthHandler))

	fmt.Printf("Server listening on port: %d\n", serverPort)
	http.ListenAndServe(fmt.Sprintf(":%d", serverPort), router)
}
