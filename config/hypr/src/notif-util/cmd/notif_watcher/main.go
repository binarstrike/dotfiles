package main

import (
	"bufio"
	"context"
	"io"
	"os"
	"os/exec"
	"time"

	"github.com/fsnotify/fsnotify"
)

func main() {
	homeDir, _ := os.UserHomeDir()
	notifFile := homeDir + "/.notif.json"
	const emptyNotif string = `{"class":"none","text":""}` + "\n"

	fileNotif, err := os.OpenFile(notifFile, os.O_RDONLY|os.O_CREATE, 0644)
	if err != nil {
		panic(err.Error())
	}
	defer fileNotif.Close()

	mpReader, mpWriter := io.Pipe()
	cmdCtx, cmdDone := context.WithCancel(context.Background())
	stopCmd := make(chan struct{})

	notifIn := make(chan []byte)
	mediaPlayerIn := make(chan []byte)

	notifWatcher := make(chan struct{})
	waitNotif := false

	fileWatcher, _ := fsnotify.NewWatcher()

	if err := fileWatcher.Add(notifFile); err != nil {
		panic(err.Error())
	}

	go notifFileWatcher(fileWatcher, notifWatcher)
	go notifReader(fileNotif, notifWatcher, notifIn)

	// TODO: menentukan jeda notifikasi berdasarkan tingkat urgency
	go func() {
		for {
			select {
			case n := <-notifIn:
				if !(len(n) > 1) {
					continue
				}
				waitNotif = true
				os.Stdout.Write(n)
				time.Sleep(time.Second * 3)
				waitNotif = false
			case n := <-mediaPlayerIn:
				os.Stdout.Write(n)
			case <-time.After(time.Second * 10):
				os.Stdout.WriteString(emptyNotif)
			}
		}
	}()

	go func() {
		defer close(stopCmd)

		scanner := bufio.NewScanner(mpReader)
		for scanner.Scan() {
			if waitNotif {
				continue
			}
			mediaPlayerIn <- append(scanner.Bytes(), 10)
		}
	}()

	cmd := exec.Command("waybar-mpris", "--position", "--autofocus")
	cmd.Stdout = mpWriter

	if err := cmd.Start(); err != nil {
		panic(err.Error())
	}

	go func() {
		cmd.Wait()
		cmdDone()
		mpWriter.Close()
	}()

	<-cmdCtx.Done()
	<-stopCmd
}

func notifFileWatcher(w *fsnotify.Watcher, watcher chan<- struct{}) {
	for {
		event, ok := <-w.Events
		if !ok {
			continue
		}

		//! ada kemungkinan event dari fsnotify terpicu lebih dari satu kali padahal file hanya ditulis satu kali
		if event.Has(fsnotify.Write) {
			watcher <- struct{}{}
		}
	}
}

func notifReader(f *os.File, watcher <-chan struct{}, notifIn chan<- []byte) {
	for {
		<-watcher
		f.Seek(0, 0)
		b, _ := io.ReadAll(f)
		notifIn <- append(b, 10) // append newline character
	}
}
