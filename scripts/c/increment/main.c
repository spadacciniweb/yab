#include <stdio.h>
#include <time.h>
#include "config.h"

int main(void) {
    Config cfg = {};

    if (load_config("../../etc/main.conf", &cfg) != 0) {
        fprintf(stderr, "Error loading configuration\n");
        return 1;
    }

    printf("C (increment)%s...%s\n",
           cfg.debug ? " in DEBUG mode" : "",
           cfg.debug ? "" : " please wait");

    long i = 0;
    long l_inc = 0;

    clock_t start = clock();

    while (i < cfg.final) {
        if (cfg.debug && (i % cfg.step == 0)) {
            printf("\rincrementing... %.1f%%",
                   (double)i * 100.0 / cfg.final);
            fflush(stdout);
        }

        char buf[32];
        l_inc += snprintf(buf, sizeof(buf), "%ld", i);
        i++;
    }

    if (cfg.debug)
        printf("\n");

    double elapsed = (double)(clock() - start) / CLOCKS_PER_SEC;

    printf("increment %ld times, total length %ld\n",
           cfg.final, l_inc);
    printf("time total: %.3f seconds\n", elapsed);

    return 0;
}

