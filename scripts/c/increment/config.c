#include "config.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

static char *trim(char *s) {
    while (isspace((unsigned char)*s))
        s++;

    if (*s == 0)
        return s;

    char *end = s + strlen(s) - 1;
    while (end > s && isspace((unsigned char)*end))
        *end-- = '\0';

    return s;
}

int load_config(const char *filename, Config *cfg) {
    FILE *fp = fopen(filename, "r");
    if (!fp) {
        perror("fopen");
        return -1;
    }

    char line[256];
    char section[64] = "";

    while (fgets(line, sizeof(line), fp)) {

        /* skip comments and  void rows  */
        char *p = trim(line);
        if (*p == '\0' || *p == '#' || *p == ';')
            continue;

        /* section */
        if (*p == '[') {
            sscanf(p, "[%63[^]]", section);
            continue;
        }

        /* keys and values */
        char key_raw[64];
        char value_raw[64];

        if (sscanf(p, "%63[^=]=%63[^\n]", key_raw, value_raw) != 2)
            continue;

        char *key = trim(key_raw);
        char *value = trim(value_raw);

        if (strcmp(section, "global") == 0) {
            if (strcmp(key, "DEBUG") == 0)
                cfg->debug = atoi(value);

        } else if (strcmp(section, "increment") == 0) {
            if (strcmp(key, "STEP") == 0)
                cfg->step = atol(value);
            else if (strcmp(key, "FINAL") == 0)
                cfg->final = atol(value);
        }
    }

    fclose(fp);
    return 0;
}
