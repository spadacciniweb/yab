all: run-all

run-all: perl-all python-all c-all go-all rust-all build-YABenchmark

perl-all:
	@echo "\n### Run Perl scripts..." && cd perl && make

python-all:
	@echo "\n\n### Run Python scripts..." && cd python && make

c-all:
	@echo "\n\n### Run C scripts..." && cd c && make

go-all:
	@echo "\n\n### Run Go scripts..." && cd go && make

rust-all:
	@echo "\n\n### Run Rust scripts..." && cd rust && make

clean:
	rm -R */output_*.log

build-YABenchmark:
	@echo "\n\nBuild YABenchmark..."
	@perl yab.pl
