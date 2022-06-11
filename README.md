# nekodroid

![Demo animation](assets/images/nekodroid_logo_regular.svg "Demo animation")

Unofficial android client for [neko-sama.fr](https://neko-sama.fr).

[Screenshots](screenshots/ "Screenshots")

## Installation

Download and install the [Latest APK](https://github.com/zkayia/nekodroid/releases/latest) or [Build](#Build) one.

## Build

Make sure to check out [docs.flutter.dev/deployment/android](https://docs.flutter.dev/deployment/android).

1. Clone this repo:
   ```
   git clone https://github.com/zkayia/nekodroid
   ```

2. Make sure your installed sdk fits the requirement in the [pubspec.yaml](pubspec.yaml) file (under `environment` > `sdk`).

3. Navigate to the project's root folder.

4. Install dependencies:
   ```
   flutter pub get
   ```

5. Follow
    [https://docs.flutter.dev/deployment/android#create-an-upload-keystore](https://docs.flutter.dev/deployment/android#create-an-upload-keystore)

   and
	  [docs.flutter.dev/deployment/android#reference-the-keystore-from-the-app](https://docs.flutter.dev/deployment/android#reference-the-keystore-from-the-app)

	 to setup apk signing.
	 Gradle configuration is already done.

6. Build the apk:
   ```
   flutter build apk
   ```
   To get an apk for each architecture add the `--split-per-abi` flag.