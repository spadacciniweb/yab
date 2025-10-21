import configparser
import time

config = configparser.ConfigParser()
config.read('etc/main.conf')

if __name__ == "__main__":
    if int(config['global']['DEBUG']):
        print("Python (increment)%s..." % (' in DEBUG mode'))
    else:
        print("Python (increment)...")

    t0, l_inc, i = time.time(), 0, 0
    step, final = int(config['increment']['STEP']), int(config['increment']['FINAL'])

    while i < final:
        if i % step == 0:
            print("\rincrementing... %.1f%%" %( i*100 / final ), end='' )
        l_inc += len(str(i))
        i += 1
    if int(config['global']['DEBUG']):
        print()

    print("increment %d times, total length %d" %( final, l_inc ) )
    print("time total: %.3f seconds" %( time.time() - t0 ) )
