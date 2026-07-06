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

dev:
	@echo "Starting development server..."
	@flutter run --dart-define=FORCE_WELCOME=true

ios-reset-build:
	@echo "Resetting iOS build..."
	@flutter clean
	@rm -rf ~/Library/Caches/org.swift.swiftpm
	@rm -rf ~/Library/Developer/Xcode/DerivedData
	@flutter pub get
	@cd ios && xcodebuild -resolvePackageDependencies -workspace Runner.xcworkspace -scheme Runner -destination 'generic/platform=iOS Simulator'
	@cd ..
	@flutter build ios --simulator --debug
