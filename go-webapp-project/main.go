package main

import (
    "fmt"
    "net/http"
)

func homeHandler(w http.ResponseWriter, r *http.Request) {
    // Check if the request path is /home
    if r.URL.Path != "/home" {
        http.NotFound(w, r)
        return
    }
    // Write the response
    fmt.Fprintln(w, "Welcome to devopsified project")
}

func main() {
    // Register the handler function for the /home path
    http.HandleFunc("/home", homeHandler)

    // Start the server on port 8080
    fmt.Println("Server is listening on port 8080...")
    if err := http.ListenAndServe(":8080", nil); err != nil {
        fmt.Printf("Error starting server: %s\n", err)
    }
}
