all: run-all

run-all: perl-all python-all rust-all

perl-all:
	@echo "### Run Perl scripts..." && cd perl && make

python-all:
	@echo "### Run Python scripts..." && cd python && make

rust-all:
	@echo "### Run Rust scripts..." && cd rust && make

clean:
	rm -R */output_*.log
