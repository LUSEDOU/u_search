clean:
	flutter clean

build-runner:
	dart run build_runner build --delete-conflicting-outputs

build: build-runner
	flutter build apk --target ./lib/main/main_development.dart

run:
	flutter run --target ./lib/main/main_development.dart

.PHONY: clean build-runner build
