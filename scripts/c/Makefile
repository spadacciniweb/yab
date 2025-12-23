all: greeting-c increment-c

greeting-c:
	@echo "\n# run greeting..." | tee output_c.log && cd greeting && make | tee -a ../output_c.log

increment-c:
	@echo "\n# run increment..." | tee -a output_c.log && cd increment && make | tee -a ../output_c.log
