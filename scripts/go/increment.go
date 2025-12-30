package main

import (
    "os"
    "fmt"
    "time"
    "gopkg.in/ini.v1"
)

func int_len(x int) int {
    len := 1

    for x >= 10 {
        x /= 10
        len++
    }
    return len
}

func main() {
    cfg, err := ini.Load("../etc/main.conf")
    if err != nil {
        fmt.Printf("Fail to read file: %v", err)
        os.Exit(1)
    }
    var debug = cfg.Section("global").Key("DEBUG").MustBool()

    if cfg.Section("global").Key("DEBUG").MustBool() {
        fmt.Println("Go (increment) in DEBUG mode...")
    } else {
        fmt.Println("Go (increment)... please wait")
    }

    var i int = 0
    var l_inc int = 0
    var step int = cfg.Section("increment").Key("STEP").MustInt()
    var final int = cfg.Section("increment").Key("FINAL").MustInt()
    t0 := time.Now()

    for i < final {
        if debug && i % step == 0 {
            fmt.Printf("\rincrementing... %.1f%%", float64(i*100) / float64(final) )
        }
        l_inc += int_len(i)
        i++
    }
    if debug {
        fmt.Println()
    }

    fmt.Printf("increment %d times, total length %d\n", final, l_inc)
    fmt.Printf("time total: %.3f seconds\n", time.Since(t0).Seconds())
}
