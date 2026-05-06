# variables
REDIS_CONTAINER_NAME := "redis-dev"
REDIS_PORT := "6379"

# default task
default:
	@just --list

# Start a local Redis instance using Podman
redis-up:
	podman run --name {{REDIS_CONTAINER_NAME}} -p {{REDIS_PORT}}:6379 -d docker.io/library/redis:alpine

# Stop and remove the local Redis instance
redis-down:
	podman stop {{REDIS_CONTAINER_NAME}} || true
	podman rm {{REDIS_CONTAINER_NAME}} || true

# View Redis logs
redis-logs:
	podman logs -f {{REDIS_CONTAINER_NAME}}

# Connect to Redis CLI
redis-cli:
	podman exec -it {{REDIS_CONTAINER_NAME}} redis-cli

# Run all go tests
test:
	go test -v ./...

# Format all go code
fmt:
	go fmt ./...

# Run a specific pattern (e.g. just run 01_primitives/01_kv_cache)
run pattern_path:
	go run patterns/{{pattern_path}}/main.go
