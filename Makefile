all: run-all

run-all: perl-all python-all rust-all build-benchmark

perl-all:
	@echo "### Run Perl scripts..." && cd perl && make

python-all:
	@echo "\n### Run Python scripts..." && cd python && make

rust-all:
	@echo "\n### Run Rust scripts..." && cd rust && make

clean:
	rm -R */output_*.log

build-benchmark:
	@echo "\nBuild benchmark..."
	@perl benchmark.pl
