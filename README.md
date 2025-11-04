# YAB - yet another benchmark

This is  collection of equivalent code samples across different programming languages — not for speed comparison, but for studying structure and style.

Despite its name, this project **is not** intended to benchmark performance between languages.  
Instead, each problem includes solutions that are as **structurally** and **functionally similar** as possible across languages.  

For some problems, a `.quick` variant is also included — offering a more idiomatic or optimized solution in the same language.

## Requirements

The requirements depend on how you plan to run the benchmark.

### running in a container

If you plan to use a containerized environment, you only need **Podman** (or **Docker**).

#### Debian / Ubuntu example

```bash
sudo apt-get update
sudo apt-get install podman
make check
```

### running on your machine

Some scripts require additional Perl modules.
You can install them using `cpan`:
```bash
cpan File::Slurp
cpan List::Util
cpan Text::ASCIITable
```

or `cpanm`:
```bash
cpanm File::Slurp
cpanm List::Util
cpanm Text::ASCIITable
```

or what you prefer.

## Running the benchmark

There are two main ways to run the benchmark, depending on your preference.

### option 1 — run locally

```bash
cd scripts
make
make clean
cd -
```

### option 2 — run via container

```bash
make
```

## Cleaning Up

Clean operations depend on your previous chosen environment.

### clean locally

```bash
cd scripts
make clean
cd -
```

### clean via container

```bash
make clean
make clean-all
```


