# 1. Mortgage Express 
- App name: Mortgage Express
- Package name: 
  iOS: com.mortgageexpressnz.mortgageexpress
    - https://apps.apple.com/sg/app/grab-superapp/id
  Android: com.mortgageexpressnz.mortgageexpress
    - https://play.google.com/store/apps/details?id=com.mortgageexpressnz.mortgageexpress

# 2. Technical Development

## 2.1 How to Run
Step 1: Install Flutter: https://flutter.dev/docs/get-started/install
  - Flutter version: '2.10'
  - Channel: stable
Step 2: Get source.
  ```
  flutter pub get
  ```
Step 3: run
  ```
  flutter run
  ```

```
  This project is a starting point for a Flutter application.
  A few resources to get you started if this is your first Flutter project:
  - [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
  - [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
  For help getting started with Flutter, view our
  [online documentation](https://flutter.dev/docs), which offers tutorials,
  samples, guidance on mobile development, and a full API reference.
```

## 2.2 API document
  - https://api.hubapi.com/

# 3. Development: How to build 
# 3.1 Flutter
```
  flutter run
```

## 3.2 Build apk release

```
  flutter build apk --split-per-abi
```

## Adroid appbundle 

```
  flutter build appbundle --release
```

