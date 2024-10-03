package main

import (
    "net/http"
    "net/http/httptest"
    "testing"
)

func TestHomeHandler(t *testing.T) {
    req, err := http.NewRequest("GET", "/home", nil)
    if err != nil {
        t.Fatal(err)
    }

    // Create a response recorder to capture the response
    rr := httptest.NewRecorder()
    handler := http.HandlerFunc(homeHandler)

    // Call the handler
    handler.ServeHTTP(rr, req)

    // Check the status code
    if status := rr.Code; status != http.StatusOK {
        t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusOK)
    }

    // Check the response body
    expected := "Welcome to devopsified project\n"
    if rr.Body.String() != expected {
        t.Errorf("handler returned unexpected body: got %v want %v", rr.Body.String(), expected)
    }
}

func TestHomeHandler_NotFound(t *testing.T) {
    req, err := http.NewRequest("GET", "/unknown", nil)
    if err != nil {
        t.Fatal(err)
    }

    rr := httptest.NewRecorder()
    handler := http.HandlerFunc(homeHandler)

    handler.ServeHTTP(rr, req)

    if status := rr.Code; status != http.StatusNotFound {
        t.Errorf("handler returned wrong status code: got %v want %v", status, http.StatusNotFound)
    }
}
