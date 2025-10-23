from hashlib import md5, sha1, sha256, sha384, sha512
import configparser
import time

config = configparser.ConfigParser()
config.read('../etc/main.conf')
debug = int(config['global']['DEBUG'])

def hashMD5(s):
    m = md5()
    bs = s.encode(encoding="ascii")
    m.update(bs)
    return m.hexdigest()

def hashSHA1(s):
    m = sha1()
    bs = s.encode(encoding="ascii")
    m.update(bs)
    return m.hexdigest()

def hashSHA256(s):
    m = sha256()
    bs = s.encode(encoding="ascii")
    m.update(bs)
    return m.hexdigest()

def hashSHA384(s):
    m = sha384()
    bs = s.encode(encoding="ascii")
    m.update(bs)
    return m.hexdigest()

def hashSHA512(s):
    m = sha512()
    bs = s.encode(encoding="ascii")
    m.update(bs)
    return m.hexdigest()

if __name__ == "__main__":
    s = 'a' * int(config['digest']['STR_SIZE'])
    s_digest_md5 = hashMD5(s)
    s_digest_sha1 = hashSHA1(s)
    s_digest_sha256 = hashSHA256(s)
    s_digest_sha384 = hashSHA384(s)
    s_digest_sha512 = hashSHA512(s)

    if debug:
        print("Python (md5, sha1, sha256, ...) in DEBUG mode...")
    else:
        print("Python (md5, sha, ...)... please wait")

    t0, l_digest_md5 = time.time(), 0
    for i in range( 1, int(config['digest']['TRIES'])+1 ):
        l_digest_md5 += len(hashMD5(s))
        if debug:
            print("\rmd5 hashing... %.1f%%" %( i*100 / int(config['digest']['TRIES']) ), end='' )

    t_digest_md5 = time.time() - t0
    if debug:
        print()

    t1, l_digest_sha1 = time.time(), 0
    for i in range( 1, int(config['digest']['TRIES'])+1 ):
        l_digest_sha1 += len(hashSHA1(s))
        if debug:
            print("\rsha1 hashing... %.1f%%" %( i*100 / int(config['digest']['TRIES']) ), end='' )

    t_digest_sha1 = time.time() - t1
    if debug:
        print()

    t2, l_digest_sha256 = time.time(), 0
    for i in range( 1, int(config['digest']['TRIES'])+1 ):
        l_digest_sha256 += len(hashSHA256(s))
        if debug:
            print("\rsha256 hashing... %.1f%%" %( i*100 / int(config['digest']['TRIES']) ), end='' )

    t_digest_sha256 = time.time() - t2
    if debug:
        print()

    t3, l_digest_sha384 = time.time(), 0
    for i in range( 1, int(config['digest']['TRIES'])+1 ):
        l_digest_sha384 += len(hashSHA384(s))
        if debug:
            print("\rsha384 hashing... %.1f%%" %( i*100 / int(config['digest']['TRIES']) ), end='' )

    t_digest_sha384 = time.time() - t3
    if debug:
        print()

    t4, l_digest_sha512 = time.time(), 0
    for i in range( 1, int(config['digest']['TRIES'])+1 ):
        l_digest_sha512 += len(hashSHA512(s))
        if debug:
            print("\rsha512 hashing... %.1f%%" %( i*100 / int(config['digest']['TRIES']) ), end='' )

    t_digest_sha512 = time.time() - t4
    if debug:
        print()

    print("md5 digest %s... to %s...: %d total length, %.2f seconds" %( s[:6], s_digest_md5[:6], l_digest_md5, t_digest_md5 ) )
    print("sha1 digest %s... to %s...: %d total length, %.2f seconds" %( s[:6], s_digest_sha1[:6], l_digest_sha1, t_digest_sha1 ) )
    print("sha256 digest %s... to %s...: %d total length, %.2f seconds" %( s[:6], s_digest_sha256[:6], l_digest_sha256, t_digest_sha256 ) )
    print("sha384 digest %s... to %s...: %d total length, %.2f seconds" %( s[:6], s_digest_sha384[:6], l_digest_sha384, t_digest_sha384 ) )
    print("sha512 digest %s... to %s...: %d total length, %.2f seconds" %( s[:6], s_digest_sha512[:6], l_digest_sha512, t_digest_sha512 ) )
    print("time total: %.3f seconds" %( t_digest_md5 + t_digest_sha1 + t_digest_sha256 + t_digest_sha384 + t_digest_sha512 ) )

