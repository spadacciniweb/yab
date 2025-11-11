all: build-image run-container exec-YABenchmark

build-image:
	@echo "Build container..."
	podman build -f container/Containerfile -t mybenchmark .

run-container:
	@echo "\nRun container..."
	podman run --name=mybench --hostname mybench --detach mybenchmark

exec-YABenchmark:
	@echo "\nRun YABenchmark..."
	podman exec -it mybench make

clean:
	@echo "\nClean... please wait"
	podman stop mybench
	podman rm mybench
	podman rmi mybenchmark

clean-all:
	podman ps -aq | xargs podman rm
	podman images -q | xargs podman rmi
	podman system prune
