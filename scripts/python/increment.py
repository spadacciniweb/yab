import configparser
import time

config = configparser.ConfigParser()
config.read('../etc/main.conf')
debug = int(config['global']['DEBUG'])

if __name__ == "__main__":
    if debug:
        print("Python (increment) in DEBUG mode...")
    else:
        print("Python (increment)... please wait")

    t0, l_inc, i = time.time(), 0, 0
    step, final = int(config['increment']['STEP']), int(config['increment']['FINAL'])

    while i < final:
        debug and i % step == 0 and print("\rincrementing... %.1f%%" %( i*100 / final ), end='', flush=True )
        l_inc += len(str(i))
        i += 1
    debug and print()

    print("increment %d times, total length %d" %( final, l_inc ) )
    print("time total: %.3f seconds" %( time.time() - t0 ) )
