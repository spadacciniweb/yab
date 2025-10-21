package main

import (
    "fmt"
    "math"
)

func main(){
    var i = 0.0
    var final = 1_000_000_000.0
    var step = final / 10

    for i < final {
        i++
        if (math.Mod(i,step) == 1) {
            fmt.Printf("\r%.1f%%", i/final*100)
        }
    }
    fmt.Println("\n",i, " end")
}


