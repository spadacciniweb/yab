import base64
import configparser
import time

config = configparser.ConfigParser()
config.read('../etc/main.conf')
debug = int(config['global']['DEBUG'])

def encodeString(s):
    s_bytes = s.encode('ascii')
    base64_bytes = base64.b64encode(s_bytes)
    return base64_bytes.decode('ascii')

def decodeString(s_64):
    base64_bytes = s_64.encode('ascii')
    s_byte = base64.b64decode(base64_bytes)
    return s_byte.decode('ascii')

if __name__ == "__main__":
    s = 'a' * int(config['base64']['STR_SIZE'])
    s_encoded = encodeString(s)
    s_decoded = decodeString(s_encoded)

    if debug:
        print("Python (base64) in DEBUG mode...")
    else:
        print("Python (base64)... please wait")

    t0, l_encoded = time.time(), 0
    for i in range( 1, int(config['base64']['TRIES'])+1 ):
        l_encoded += len(encodeString(s))
        if debug:
            print("\rencoding... %.1f%%" %( i*100 / int(config['base64']['TRIES']) ), end='', flush=True )
    t_encoded = time.time() - t0
    if debug:
        print()

    t1, l_decoded = time.time(), 0
    for i in range( 1, int(config['base64']['TRIES'])+1 ):
        l_decoded += len(decodeString(s_encoded))
        if debug:
            print("\rdecoding... %.1f%%" %( i*100 / int(config['base64']['TRIES']) ), end='', flush=True )
    t_decoded = time.time() - t1
    if debug:
        print()

    print("encode %s... to %s...: %d total length, %.2f seconds" %( s[:6], s_encoded[:6], l_encoded, t_encoded ) )
    print("decode %s... to %s...: %d total length, %.2f seconds" %( s_encoded[:6], s_decoded[:6], l_decoded, t_decoded ) )
    print("time total: %.3f seconds" %( t_encoded + t_decoded ) )
