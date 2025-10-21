use std::io::{self, Write};
use std::time::{Instant};
use ini::Ini;

fn main() {
    let conf = Ini::load_from_file("../../etc/main.conf").unwrap();
    let section_global = conf.section(Some("global")).unwrap();
    let debug = section_global.get("DEBUG").unwrap().parse::<i32>().unwrap() == 1;
    let section_increment = conf.section(Some("increment")).unwrap();
    let fin = section_increment.get("FINAL").unwrap().parse::<f64>().unwrap();
    let step = section_increment.get("STEP").unwrap().parse::<f64>().unwrap();
    let t0 = Instant::now();

    if debug {
        println!("Rust (increment) in DEBUG mode...");
    } else {
        println!("Rust (increment)...");
    }

    let mut i = 0.0;
    let mut l_inc = 0;

    while i < fin {
        if debug && ( ( i % step) as i32 == 1 ) {
            print!("\rincrementing... {:.1}%", i * 100.0 / fin );
            let _ = io::stdout().flush();
        }
        l_inc = l_inc + i.to_string().len();
        i = i + 1.0;
    }
    if debug {
        println!("");
    }

    println!("increment {} times, total length {}", fin, l_inc);
    println!("time total: {:.3} seconds", t0.elapsed().as_millis() as f64 / 1000.0);
}
