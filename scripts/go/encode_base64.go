package main

import (
    "os"
    "fmt"
    "strings"
    "time"
    "gopkg.in/ini.v1"
    b64 "encoding/base64"
)

func main(){
    cfg, err := ini.Load("../etc/main.conf")
    if err != nil {
        fmt.Printf("Fail to read file: %v", err)
        os.Exit(1)
    }
    var debug = cfg.Section("global").Key("DEBUG").MustBool()
    var str_size float64 = cfg.Section("base64").Key("STR_SIZE").MustFloat64()
    var tries float64 = cfg.Section("base64").Key("TRIES").MustFloat64()

    if cfg.Section("global").Key("DEBUG").MustBool() {
        fmt.Println("Go (encoding/base64) in DEBUG mode...")
    } else {
        fmt.Println("Go (encoding/base64)... please wait")
    }

    t_encode := time.Now()

    s := strings.Repeat("a", int(str_size))
    s_encoded := b64.StdEncoding.EncodeToString([]byte(s))
    s_decoded, _ := b64.StdEncoding.DecodeString(s_encoded)
 
    var l_encoded = 0 
    var i = 0.0
    for i < tries {
        l_encoded += len( b64.StdEncoding.EncodeToString([]byte(s)) )
        if (debug) {
            fmt.Printf("\rencoding... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_encoded := time.Since(t_encode).Seconds()
    if debug {
        fmt.Println()
    }

    t_decode := time.Now()
    var l_decoded = 0 
    i = 0.0
    for i < tries {
        s_decoded, _ := b64.StdEncoding.DecodeString(s_encoded)
        l_decoded += len( s_decoded )
        if (debug) {
            fmt.Printf("\rdecoding... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_decoded := time.Since(t_decode).Seconds()
    if debug {
        fmt.Println()
    }

    fmt.Printf("encode %s... to %s...: %d total length, %.3f seconds\n", s[:6], s_encoded[:6], l_encoded, t_encoded)
    fmt.Printf("decode %s... to %s...: %d total length, %.3f seconds\n", s_encoded[:6], s_decoded[:6], l_decoded, t_decoded)

    fmt.Printf("time total: %.3f seconds\n", time.Since(t_encode).Seconds())
}
