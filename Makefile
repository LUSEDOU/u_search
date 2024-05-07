clean:
	flutter clean

build-runner:
	dart run build_runner build --delete-conflicting-outputs && \
		cd api && \
		dart run build_runner build --delete-conflicting-outputs && \
		cd ..

build: build-runner
	flutter build web --target ./lib/main/main_development.dart

runw:
	flutter run --target ./lib/main/main_development.dart -d chrome

run:
	flutter run --target ./lib/main/main_development.dart -d linux

.PHONY: clean build-runner build
