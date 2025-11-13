all: run-all

run-all: perl-all python-all go-all rust-all build-YABenchmark

perl-all:
	@echo "### Run Perl scripts..." && cd perl && make

python-all:
	@echo "\n\n### Run Python scripts..." && cd python && make

go-all:
	@echo "\n\n### Run Go scripts..." && cd go && make

rust-all:
	@echo "\n\n### Run Rust scripts..." && cd rust && make

clean:
	rm -R */output_*.log

build-YABenchmark:
	@echo "\n\nBuild YABenchmark..."
	@perl yab.pl
