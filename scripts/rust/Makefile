all: increment-rs encode_base64-rs digest-rs

increment-rs:
	@echo "\n# run increment..." | tee output_rust.log && cd increment && make | tee -a ../output_rust.log

encode_base64-rs:
	@echo "\n# run encode_base64..." | tee -a output_rust.log && cd encode_base64 && make | tee -a ../output_rust.log

digest-rs:
	@echo "\n# run digest..." | tee -a output_rust.log && cd digest && make | tee -a ../output_rust.log

