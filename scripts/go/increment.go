package main

import (
    "os"
    "fmt"
    "math"
    "strconv"
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
        fmt.Println("Go (increment) in DEBUG mode...")
    } else {
        fmt.Println("Go (increment)... please wait")
    }

    var i int64 = 0
    var l_inc int = 0
    var step int64 = cfg.Section("increment").Key("STEP").MustInt64(9999999)
    var final int64 = cfg.Section("increment").Key("FINAL").MustInt64(99999999999999999)
    t0 := time.Now()

    for i < final {
        if (debug && int( math.Mod( float64(i), float64(step) ) ) == 1) {
            fmt.Printf("\rincrementing... %.1f%%", float64(i*100) / float64(final) )
        }
        l_inc += len(strconv.FormatInt(int64(i), 10))
        i++
    }
    if debug {
        fmt.Println()
    }

    fmt.Printf("increment %d times, total length %d\n", final, l_inc)
    fmt.Printf("time total: %.3f seconds\n", time.Since(t0).Seconds())
}
