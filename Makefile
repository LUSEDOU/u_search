clean:
	flutter clean

build-runner:
	flutter pub run build_runner build --delete-conflicting-outputs

build:
	flutter build apk

.PHONY: clean build-runner build
