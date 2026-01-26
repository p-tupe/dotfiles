// package check-sites is a health monitoring tool
// that pings a list of sites (urls) and ensures they're up.
package main

import (
	"fmt"
	"log"
	"net/http"
	"strings"
	"time"
)

var sites = [...]string{
	"https://priteshtupe.com",
	"https://vpn.priteshtupe.com",
	"https://nextcloud.priteshtupe.com",
	"https://vaultwarden.priteshtupe.com",
	"https://cloud.priteshtupe.com",
	"https://excalidraw.priteshtupe.com",
	"https://umami.priteshtupe.com",
	// "https://codapi.priteshtupe.com", => ???
	"https://app.priteshtupe.com/gtask/health",
}

func main() {
	log.Println("Pingmon started...")
	tick := time.Tick(30 * time.Minute)

	for {
		<-tick
		for _, site := range sites {
			go check(site)
		}
	}
}

// check starts a ticker that checks for a
// successful response from `site` every 30m
func check(site string) {
	resp, err := http.Get(site)
	if err != nil {
		msg := fmt.Sprintf("Error while checking site %s: %v\n", site, err)
		log.Println(msg)
		alert(msg)
		return
	}

	if site == "https://vpn.priteshtupe.com" {
		if resp.StatusCode != http.StatusUnauthorized {
			msg := fmt.Sprintf("Error while checking site %s: %v\n", site, resp.Status)
			log.Println(msg)
			alert(msg)
			return
		}
	} else if resp.StatusCode > http.StatusMultipleChoices {
		msg := fmt.Sprintf("Error while checking site %s: %v\n", site, resp.Status)
		log.Println(msg)
		alert(msg)
		return
	}

	log.Println(site, ":", resp.Status)
}

// alert sends a `msg` to the email using the
// authorization code from env var
func alert(msg string) {
	log.Println("Generating alert...")

	req, err := http.NewRequest(http.MethodPost, "https://app.priteshtupe.com/mail", strings.NewReader(msg))
	if err != nil {
		log.Println("Error while creating alert:", err)
		return
	}
	req.Header.Add("Authorization", "+ugwY4jSfRC2dx3RwPYR7dDwFT0ilK42TrhOUGpjqOA4Cg==")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		log.Println("Error while sending alert:", err)
		return
	}

	if resp.StatusCode != http.StatusAccepted {
		log.Println("Error while sending alert:", resp.Status)
		return
	}

	log.Println("Alert sent!")
}
