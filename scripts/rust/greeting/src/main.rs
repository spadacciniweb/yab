use std::io::{self, Write};
use std::time::{Instant};
use ini::Ini;

fn main() {
    let conf = Ini::load_from_file("../../etc/main.conf").unwrap();
    let section_global = conf.section(Some("global")).unwrap();
    let debug = section_global.get("DEBUG").unwrap().parse::<i32>().unwrap() == 1;
    let section_greeting = conf.section(Some("greeting")).unwrap();
    let fin = section_greeting.get("FINAL").unwrap().parse::<f64>().unwrap();
    let greeting = section_greeting.get("GREETING").unwrap();
    let t0 = Instant::now();

    if debug {
        println!("Rust (greeting) in DEBUG mode...");
    } else {
        println!("Rust (greeting)... please wait");
    }

    let mut i = 0.0;
    let mut l_greeting = 0;

    while i < fin {
        print!("\r{}...", greeting );
        if debug {
            print!(" {:.1}%", i * 100.0 / fin );
        }
        let _ = io::stdout().flush();
        l_greeting = l_greeting + greeting.len();
        i = i + 1.0;
    }
    if debug {
        println!("");
    }

    println!("{} {} times, total length {}", greeting, fin, l_greeting);
    println!("time total: {:.3} seconds", t0.elapsed().as_millis() as f64 / 1000.0);
}
