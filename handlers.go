package goserverlessapi

import "net/http"

const (
	msgHealthOk = "ok"
)

// HealthHandler is an endpoint for healthchecks
func HealthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("ok"))
}
