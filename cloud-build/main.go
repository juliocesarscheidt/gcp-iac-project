package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

func buildJSONResponse(statusCode int, message string) ([]byte, error) {
	var responseHTTP = make(map[string]interface{})

	responseHTTP["statusCode"] = statusCode
	responseHTTP["data"] = message

	response, err := json.Marshal(responseHTTP)
	if err != nil {
		return nil, err
	}

	return []byte(string(response)), nil
}

func returnHTTPResponse(statusCode int, message string) http.HandlerFunc {
	return func(writter http.ResponseWriter, req *http.Request) {
		responseJSONBytes, _ := buildJSONResponse(statusCode, message)

		writter.Header().Set("Content-Type", "application/json")
		writter.WriteHeader(statusCode)
		writter.Write(responseJSONBytes)
	}
}

func ternary(statement bool, a, b interface{}) interface{} {
	if statement {
		return a
	}
	return b
}

func serve(address string, message string) {
	http.HandleFunc("/", returnHTTPResponse(http.StatusOK, message))
	http.HandleFunc("/healthcheck", returnHTTPResponse(http.StatusOK, "OK"))

	fmt.Printf("[INFO] Listening on %s\n", address)
	http.ListenAndServe(address, nil)
}

func main() {
	port := ternary(os.Getenv("API_PORT") != "", os.Getenv("API_PORT"), "9000").(string) // default 9000
	address := fmt.Sprintf(":%s", port)
	fmt.Printf("[INFO] Address :: %s\n", address)

	message := ternary(os.Getenv("MESSAGE") != "", os.Getenv("MESSAGE"), "Hello World V2").(string) // default Hello World
	fmt.Printf("[INFO] Message :: %s\n", message)

	serve(address, message)
}
