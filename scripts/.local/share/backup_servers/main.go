//usr/bin/env go run "$0" "$@"; exit "$?"

// Package backup-servers is a script that pulls all non-hidden data from
// given server SSH URLs and into a backup directory
//
// Usage: go run .
// Install: go install .
package main

import (
	"log"
	"os"
	"os/exec"
	"path"
	"sync"
)

func main() {
	var wg sync.WaitGroup

	wg.Go(func() {
		backup("toronto-server:/home/ubuntu", path.Join(getBackupDir(), "toronto-server"))
	})

	wg.Go(func() {
		backup("badass-server:/home/ubuntu", path.Join(getBackupDir(), "badass-server"))
	})

	wg.Wait()
	log.Println("Done!")
}

func getBackupDir() string {
	home, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err)
	}
	return path.Join(home, "Backups")
}

func backup(serverDir, backupDir string) {
	log.Printf("Backing up %s to %s", serverDir, backupDir)
	cmd := exec.Command("rsync", "-azrq", "--partial",
		"--exclude", ".*",
		"--exclude", "immich-app/postgres",
		"--exclude", "wg-easy/wg0.conf",
		"--exclude", "wg-easy/wg0.json",
		"--delete", "--ignore-errors", serverDir, backupDir)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		log.Fatalf("Error while running cmd: %v", err)
	}
}
