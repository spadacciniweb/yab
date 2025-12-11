import configparser
import time

config = configparser.ConfigParser()
config.read('../etc/main.conf')
debug = int(config['global']['DEBUG'])

if __name__ == "__main__":
    if debug:
        print("Python (greeting) in DEBUG mode...")
    else:
        print("Python (greeting)... please wait")

    t0, l_greeting, i = time.time(), 0, 0
    greeting = config['greeting']['GREETING']
    final = int(config['greeting']['FINAL'])

    while i < final:
        print("\r%s..." %( greeting ), end='', flush=True )
        debug and print(" %.1f%%" %( i*100 / final ), end='', flush=True )
        l_greeting += len(greeting)
        i += 1
    print()

    print("'%s' %d times, total length %d" %( greeting, final, l_greeting ) )
    print("time total: %.3f seconds" %( time.time() - t0 ) )
