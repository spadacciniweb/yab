#include <stdio.h>
#include <time.h>
#include <string.h>
#include "config.h"

int main(void)
{
    Config cfg = {0};

    if (load_config("../../etc/main.conf", &cfg) != 0) {
        fprintf(stderr, "Errore nel caricamento della configurazione\n");
        return 1;
    }

    printf("C (greeting)%s...%s\n",
           cfg.debug ? " in DEBUG mode" : "",
           cfg.debug ? "" : " please wait");

    long i = 0;
    long l_greeting = 0;

    const char *greeting = cfg.greeting;
    long final = cfg.final;

    clock_t t0 = clock();

    while (i < final) {
        printf("\r%s...", greeting);

        if (cfg.debug) {
            printf(" %.1f%%", (double)i * 100.0 / final);
        }

        l_greeting += strlen(greeting);
        i++;
    }

    printf("\n");

    printf("'%s' %ld times, total length %ld\n",
           greeting, final, l_greeting);

    double elapsed = (double)(clock() - t0) / CLOCKS_PER_SEC;
    printf("time total: %.3f seconds\n", elapsed);

    return 0;
}

