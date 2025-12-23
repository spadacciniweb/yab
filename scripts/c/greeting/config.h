#ifndef CONFIG_H
#define CONFIG_H

typedef struct {
    int debug;
    char greeting[128];
    long final;
} Config;

int load_config(const char *filename, Config *cfg);

#endif

