package main

import (
    "os"
    "fmt"
    "strings"
    "time"
    "gopkg.in/ini.v1"
    "crypto/md5"
    "crypto/sha1"
    "crypto/sha256"
    "crypto/sha512"
)

func get_md5(s string) string {
    hash := md5.New()
    hash.Write([]byte(s))
    return fmt.Sprintf("%x", hash.Sum(nil))
}

func get_sha1(s string) string {
    hash := sha1.New()
    hash.Write([]byte(s))
    return fmt.Sprintf("%x", hash.Sum(nil))
}

func get_sha256(s string) string {
    hash := sha256.New()
    hash.Write([]byte(s))
    return fmt.Sprintf("%x", hash.Sum(nil))
}

func get_sha384(s string) string {
    hash := sha512.New384()
    hash.Write([]byte(s))
    return fmt.Sprintf("%x", hash.Sum(nil))
}

func get_sha512(s string) string {
    hash := sha512.New()
    hash.Write([]byte(s))
    return fmt.Sprintf("%x", hash.Sum(nil))
}

func main(){
    cfg, err := ini.Load("../etc/main.conf")
    if err != nil {
        fmt.Printf("Fail to read file: %v", err)
        os.Exit(1)
    }
    var debug = cfg.Section("global").Key("DEBUG").MustBool()
    var str_size int = cfg.Section("digest").Key("STR_SIZE").MustInt()
    var tries float64 = cfg.Section("digest").Key("TRIES").MustFloat64()

    if cfg.Section("global").Key("DEBUG").MustBool() {
        fmt.Println("Go (crypto/md5, crypto/sha1, crypto/sha256, crypto/sha512) in DEBUG mode...")
    } else {
        fmt.Println("Go (crypto/md5, crypto/sha1, crypto/sha256, crypto/sha512)... please wait")
    }

    s := strings.Repeat("a", int(str_size))
    s_digest_md5 := get_md5(s)
    s_digest_sha1 := get_sha1(s)
    s_digest_sha256 := get_sha256(s)
    s_digest_sha384 := get_sha384(s)
    s_digest_sha512 := get_sha512(s)

    t_md5 := time.Now()
    var l_digest_md5 = 0 

    var i = 0.0
    for i < tries {
        l_digest_md5 += len( get_md5(s) )
        if (debug) {
            fmt.Printf("\rmd5 hashing... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_digest_md5 := time.Since(t_md5).Seconds()
    if debug {
        fmt.Println()
    }

    t_sha1 := time.Now()
    var l_digest_sha1 = 0 

    i = 0.0
    for i < tries {
        l_digest_sha1 += len( get_sha1(s) )
        if (debug) {
            fmt.Printf("\rsha1 hashing... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_digest_sha1 := time.Since(t_sha1).Seconds()
    if debug {
        fmt.Println()
    }

    t_sha256 := time.Now()
    var l_digest_sha256 = 0 

    i = 0.0
    for i < tries {
        l_digest_sha256 += len( get_sha256(s) )
        if (debug) {
            fmt.Printf("\rsha256 hashing... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_digest_sha256 := time.Since(t_sha256).Seconds()
    if debug {
        fmt.Println()
    }

    t_sha384 := time.Now()
    var l_digest_sha384 = 0 

    i = 0.0
    for i < tries {
        l_digest_sha384 += len( get_sha384(s) )
        if (debug) {
            fmt.Printf("\rsha384 hashing... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_digest_sha384 := time.Since(t_sha384).Seconds()
    if debug {
        fmt.Println()
    }

    t_sha512 := time.Now()
    var l_digest_sha512 = 0 

    i = 0.0
    for i < tries {
        l_digest_sha512 += len( get_sha512(s) )
        if (debug) {
            fmt.Printf("\rsha512 hashing... %.1f%%", i * 100.0 / tries )
        }
        i++
    }
    t_digest_sha512 := time.Since(t_sha512).Seconds()
    if debug {
        fmt.Println()
    }

    fmt.Printf("md5 digest %s... to %s...: %d total length, %.3f seconds\n", s[:6], s_digest_md5[:6], l_digest_md5, t_digest_md5)
    fmt.Printf("sha1 digest %s... to %s...: %d total length, %.3f seconds\n", s[:6], s_digest_sha1[:6], l_digest_sha1, t_digest_sha1)
    fmt.Printf("sha256 digest %s... to %s...: %d total length, %.3f seconds\n", s[:6], s_digest_sha256[:6], l_digest_sha256, t_digest_sha256)
    fmt.Printf("sha384 digest %s... to %s...: %d total length, %.3f seconds\n", s[:6], s_digest_sha384[:6], l_digest_sha384, t_digest_sha384)
    fmt.Printf("sha512 digest %s... to %s...: %d total length, %.3f seconds\n", s[:6], s_digest_sha512[:6], l_digest_sha512, t_digest_sha512)

    fmt.Printf("time total: %.3f seconds\n", time.Since(t_md5).Seconds())
}
