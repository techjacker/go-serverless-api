package main

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/julienschmidt/httprouter"
)

func TestHealthHandler(t *testing.T) {
	const (
		testPath = "/healthz"
	)

	tests := []struct {
		name           string
		wantStatusCode int
		wantResBody    string
	}{
		{
			name:           "Healthcheck handler",
			wantStatusCode: http.StatusOK,
			wantResBody:    msgHealthOk,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {

			router := httprouter.New()
			router.Handler("GET", testPath, http.HandlerFunc(HealthHandler))

			r, err := http.NewRequest("GET", testPath, nil)
			if err != nil {
				t.Error(err)
			}
			w := httptest.NewRecorder()
			router.ServeHTTP(w, r)

			if w.Code != tt.wantStatusCode {
				t.Fatalf("Healthhandler returned unexpected status code: got %v want %v",
					w.Code, tt.wantStatusCode)
			}
			if strings.EqualFold(strings.TrimSpace(w.Body.String()), tt.wantResBody) != true {
				t.Fatalf("Healthhandler returned unexpected body: got %v want %v",
					w.Body.String(), tt.wantResBody)
			}
		})
	}

}
