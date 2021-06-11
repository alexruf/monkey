package main

import (
	"fmt"
	"os"
	"os/user"

	"github.com/alexruf/monkey/repl"
)

// nolint
var (
	version = "dev"
	commit  = ""
	date    = ""
	builtBy = ""
)

func main() {
	usr, err := user.Current()
	if err != nil {
		panic(err)
	}
	fmt.Printf("Hello %s! This is the Monkey programming language! (%s)\n", usr.Username, version)
	fmt.Print("Feel free to type in commands\n")
	repl.Start(os.Stdin, os.Stdout)
}
