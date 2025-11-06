all: increment-rs digest-rs

increment-rs:
	@echo "# run increment..." | tee output_rust.log && cd increment && make | tee -a ../output_rust.log

digest-rs:
	@echo "# run digest..." | tee -a output_rust.log && cd digest && make | tee -a ../output_rust.log

