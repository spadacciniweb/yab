use std::io::{self, Write};
use std::time::{Instant};
use ini::Ini;
use base64::{engine::general_purpose::STANDARD, Engine as _};

fn main() {
    let conf = Ini::load_from_file("../../etc/main.conf").unwrap();
    let section_global = conf.section(Some("global")).unwrap();
    let debug = section_global.get("DEBUG").unwrap().parse::<i32>().unwrap() == 1;
    let section_base64 = conf.section(Some("base64")).unwrap();
    let str_size = section_base64.get("STR_SIZE").unwrap().parse::<usize>().unwrap();
    let tries = section_base64.get("TRIES").unwrap().parse::<f64>().unwrap();

    if debug {
        println!("Rust (base64) in DEBUG mode...");
    } else {
        println!("Rust (base64)... please wait");
    }

    let t_encode = Instant::now();

    let s = "a".repeat(str_size);
    let s_encoded = STANDARD.encode(s.clone());
    let s_decoded = String::from_utf8( STANDARD.decode(s_encoded.clone()).unwrap() ).unwrap();

    let mut l_encoded = 0;
    let mut i = 0.0;
    while i < tries {
        l_encoded = l_encoded + STANDARD.encode(s.clone()).len();
        if debug {
            print!("\rencoding... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_encoded = Instant::now().duration_since(t_encode);
    if debug {
        println!("");
    }
    let t_decode = Instant::now();
    let mut l_decoded = 0;
    i = 0.0;
    while i < tries {
        l_decoded = l_decoded + String::from_utf8( STANDARD.decode(s_encoded.clone()).unwrap() ).unwrap().len();
        if debug {
            print!("\rdecoding... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_decoded = Instant::now().duration_since(t_decode);
    if debug {
        println!("");
    }

    println!("encode {}... to {}...: {} total length, {} seconds", s.get(0..6).unwrap(), s_encoded.get(0..6).unwrap(), l_encoded, t_encoded.as_millis() as f64 / 1000.0 );
    println!("decode {}... to {}...: {} total length, {} seconds", s_encoded.get(0..6).unwrap(), s_decoded.get(0..6).unwrap(), l_decoded, t_decoded.as_millis() as f64 / 1000.0 );

    println!("time total: {:.3} seconds", t_encode.elapsed().as_millis() as f64 / 1000.0);
}
