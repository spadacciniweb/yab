import configparser
import time

config = configparser.ConfigParser()
config.read('etc/main.conf')

if __name__ == "__main__":
    if int(config['global']['DEBUG']):
        print("Python (increment)%s..." % (' in DEBUG mode'))
    else:
        print("Python (increment)...")

    t0, i, step, final = time.time(), 0, int(config['increment']['STEP']), int(config['increment']['FINAL'])

    while i < final:
        if i % step == 0:
            print("\rincrementing... %.1f%%" %( i*100 / final ), end='' )
        i += 1

    print()

    print("increment %d times" %( final ) )
    print("time total: %.3f seconds" %( time.time() - t0 ) )
