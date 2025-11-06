use std::io::{self, Write};
use std::time::{Instant};
use ini::Ini;
use md5;
use sha1::{Sha1};
use sha2::{Sha256, Sha384, Sha512, Digest};

fn main() {
    let conf = Ini::load_from_file("../../etc/main.conf").unwrap();
    let section_global = conf.section(Some("global")).unwrap();
    let debug = section_global.get("DEBUG").unwrap().parse::<i32>().unwrap() == 1;
    let section_digest = conf.section(Some("digest")).unwrap();
    let str_size = section_digest.get("STR_SIZE").unwrap().parse::<usize>().unwrap();
    let tries = section_digest.get("TRIES").unwrap().parse::<f64>().unwrap();

    if debug {
        println!("Rust (md5, sha1, sha2) in DEBUG mode...");
    } else {
        println!("Rust (md5, sha1, sha2)... please wait");
    }

    let s = "a".repeat(str_size);
    let digest_md5: String = format!("{:x}", md5::compute(s.clone()));
    let digest_sha1: String = format!("{:x}", Sha1::digest(s.clone()));
    let digest_sha256: String = format!("{:x}", Sha256::digest(s.clone()));
    let digest_sha384: String = format!("{:x}", Sha384::digest(s.clone()));
    let digest_sha512: String = format!("{:x}", Sha512::digest(s.clone()));

    let t_md5 = Instant::now();
    let mut l_digest_md5 = 0;
    let mut i = 0.0;
    while i < tries {
        l_digest_md5 = l_digest_md5 + md5::compute(s.clone()).len();
        if debug {
            print!("\rmd5 hashing... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_digest_md5 = Instant::now().duration_since(t_md5);
    if debug {
        println!("");
    }

    let t_sha1 = Instant::now();
    let mut l_digest_sha1 = 0;
    i = 0.0;
    while i < tries {
        l_digest_sha1 = l_digest_sha1 + Sha1::digest(s.clone()).len();
        if debug {
            print!("\rsha1 hashing... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_digest_sha1 = Instant::now().duration_since(t_sha1);
    if debug {
        println!("");
    }

    let t_sha256 = Instant::now();
    let mut l_digest_sha256 = 0;
    i = 0.0;
    while i < tries {
        l_digest_sha256 = l_digest_sha256 + Sha256::digest(s.clone()).len();
        if debug {
            print!("\rsha256 hashing... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_digest_sha256 = Instant::now().duration_since(t_sha256);
    if debug {
        println!("");
    }

    let t_sha384 = Instant::now();
    let mut l_digest_sha384 = 0;
    i = 0.0;
    while i < tries {
        l_digest_sha384 = l_digest_sha384 + Sha384::digest(s.clone()).len();
        if debug {
            print!("\rsha384 hashing... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_digest_sha384 = Instant::now().duration_since(t_sha384);
    if debug {
        println!("");
    }

    let t4 = Instant::now();
    let mut l_digest_sha512 = 0;
    i = 0.0;
    while i < tries {
        l_digest_sha512 = l_digest_sha512 + Sha512::digest(s.clone()).len();
        if debug {
            print!("\rsha512 hashing... {:.1}%", i * 100.0 / tries );
            let _ = io::stdout().flush();
        }
        i = i + 1.0;
    }
    let t_digest_sha512 = Instant::now().duration_since(t4);
    if debug {
        println!("");
    }

    println!("md5 digest {}... to {}...: {} total length, {} seconds", s.get(0..6).unwrap(), digest_md5.get(0..6).unwrap(), l_digest_md5, t_digest_md5.as_millis() as f64 / 1000.0 );
    println!("sha1 digest {}... to {}...: {} total length, {} seconds", s.get(0..6).unwrap(), digest_sha1.get(0..6).unwrap(), l_digest_sha1, t_digest_sha1.as_millis() as f64 / 1000.0 );
    println!("sha256 digest {}... to {}...: {} total length, {} seconds", s.get(0..6).unwrap(), digest_sha256.get(0..6).unwrap(), l_digest_sha256, t_digest_sha256.as_millis() as f64 / 1000.0 );
    println!("sha384 digest {}... to {}...: {} total length, {} seconds", s.get(0..6).unwrap(), digest_sha384.get(0..6).unwrap(), l_digest_sha384, t_digest_sha384.as_millis() as f64 / 1000.0 );
    println!("sha512 digest {}... to {}...: {} total length, {} seconds", s.get(0..6).unwrap(), digest_sha512.get(0..6).unwrap(), l_digest_sha512, t_digest_sha512.as_millis() as f64 / 1000.0 );

    println!("time total: {:.3} seconds", t_md5.elapsed().as_millis() as f64 / 1000.0);
}
