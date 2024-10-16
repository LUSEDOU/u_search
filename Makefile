FLUTTER = fvm flutter

clean:
	$(FLUTTER) clean

build-runner:
	dart run build_runner build --delete-conflicting-outputs && \
		cd api && \
		dart run build_runner build --delete-conflicting-outputs && \
		cd ..

build: build-runner
	$(FLUTTER) build web --target ./lib/main/main_development.dart

runw:
	$(FLUTTER) run --target ./lib/main/main_development.dart -d chrome

run:
	$(FLUTTER) run --target ./lib/main/main_development.dart -d linux

runm:
	$(FLUTTER) run --target ./lib/main/main_development.dart -d macos

rund:
	$(FLUTTER) run --target ./lib/main/main_development.dart -d windows

.PHONY: clean build-runner build
