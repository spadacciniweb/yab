package main

import (
    "os"
    "fmt"
    "time"
    "gopkg.in/ini.v1"
)

func main(){
    cfg, err := ini.Load("../etc/main.conf")
    if err != nil {
        fmt.Printf("Fail to read file: %v", err)
        os.Exit(1)
    }
    var debug = cfg.Section("global").Key("DEBUG").MustBool()

    if cfg.Section("global").Key("DEBUG").MustBool() {
        fmt.Println("Go (greeting) in DEBUG mode...")
    } else {
        fmt.Println("Go (greeting)... please wait")
    }

    var i int64 = 0
    var l_greeting int = 0
    var greeting string = cfg.Section("greeting").Key("GREETING").MustString("Hello world!!")
    var final int64 = cfg.Section("greeting").Key("FINAL").MustInt64(99999999)
    t0 := time.Now()

    for i < final {
           fmt.Printf("\r%s...", greeting )
        if (debug) {
            fmt.Printf(" %.1f%%", float64(i*100) / float64(final) )
        }
        l_greeting += len(greeting)
        i++
    }
    fmt.Println()

    fmt.Printf("'%s' %d times, total length %d\n", greeting, final, l_greeting)
    fmt.Printf("time total: %.3f seconds\n", time.Since(t0).Seconds())
}
