package main

import "net/http"

const (
	msgHealthOk   = "ok"
	msgBadRequest = "bad request"
)

// HealthHandler is an endpoint for healthchecks
func HealthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte(msgHealthOk))
}
