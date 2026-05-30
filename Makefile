.PHONY: out up analyze test check

init:
	@echo "Initializing project..."
	@pre-commit install
	@flutter pub get

out:
	@echo "Checking for outdated dependencies..."
	@flutter pub outdated

up:
	@echo "Upgrading dependencies..."
	@flutter pub upgrade

clean:
	@echo "Cleaning project..."
	@flutter clean
	@flutter pub get

analyze:
	@echo "Running static analysis..."
	@flutter analyze

test:
	@echo "Running tests..."
	@flutter test

check:
	@echo "Pre-commit check..."
	@pre-commit run --all-files
