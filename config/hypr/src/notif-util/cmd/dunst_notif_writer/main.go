package main

import (
	"encoding/json"
	"fmt"
	"notifutil"
	"os"
	"strings"
)

func main() {
	homeDir, _ := os.UserHomeDir()
	notifFile := homeDir + "/.notif.json"

	// appname, summary, body, icon_path, urgency.

	notifData := notifutil.WaybarStruct{
		Class:   strings.ToLower(os.Args[5]),
		Text:    fmt.Sprintf("[%s] %s", os.Args[1], os.Args[2]),
		Tooltip: os.Args[2],
	}

	f, err := os.OpenFile(notifFile, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0644)
	if err != nil {
		f.Close()
		return
	}

	d, _ := json.Marshal(notifData)

	f.Write(d)
	f.Close()
}
