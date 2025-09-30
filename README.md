# PharmaLink — Submission Package
**Project:** PharmaLink (Flutter mobile app)
**Repository root:** `pharmalink-main`
**Files in project:** 150

---
## 1) Front-end (Client)
- **Framework:** Flutter (Dart)
- **Project path:** `lib/`
- **Key pages / widgets:**
- `main.dart`
- `pages/EditMedicinesPage.dart`
- `pages/OrdersPage.dart`
- `pages/adminPage.dart`
- `pages/bottomNavBar.dart`
- `pages/cart.dart`
- `pages/checkout.dart`
- `pages/contactUs.dart`
- `pages/home.dart`
- `pages/login.dart`
- `pages/orderTrack.dart`
- `pages/prescriptionUpload.dart`
- `pages/profile.dart`
- `pages/savedPrescriptionsPage.dart`
- `pages/search.dart`
- `pages/signUp.dart`
- `pages/starter.dart`
- `widget/support_widget.dart`

- **UI/UX notes:** Mobile-first design, uses `curved_navigation_bar` for bottom navigation.

## 2) Back-end
- **Platform:** Firebase
  - `firebase_core`, `firebase_auth` for authentication
  - `cloud_firestore` for app data (products, orders, users)
  - `firebase_storage` for storing uploaded prescriptions/images
- **Config files found:** `android/app/google-services.json` (present)
- **Authentication:** Email/password via `firebase_auth`
- **Database:** Cloud Firestore used for orders, products, carts (see code under `lib/pages`).

## 3) Dependencies (from `pubspec.yaml`)
  flutter:
    sdk: flutter
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8
  curved_navigation_bar: ^1.0.6
  firebase_core: ^4.1.1
  firebase_auth: ^6.1.0
  cloud_firestore: ^6.0.2
  image_picker: ^1.2.0
  firebase_storage: ^13.0.2

## 4) What’s completed (observed from source)
- User authentication: Sign up, login, profile page.
- Product browsing / search page.
- Cart management and checkout page.
- Prescription upload and saved prescriptions.
- Order placement and order tracking pages.
- Admin page (for admin actions).
- Integration with Firebase (initialization done in `main.dart`).

> **Note:** I inspected the source code to determine these completed features. If you (or your team) implemented additional features not present in the `lib/` folder, add them to this document.

## 5) How to run the app (local)
1. Install Flutter SDK (stable channel).
2. From project root (`pharmalink-main/pharmalink-main`) run:

```
flutter pub get
```

3. Ensure Firebase configuration files are correct:
   - Android: `android/app/google-services.json` (already present)
   - iOS: `ios/Runner/GoogleService-Info.plist` (verify)
4. Run on connected device or emulator:

```
flutter run
```

5. If building for release, follow Flutter docs for Android/iOS signing.

## 6) Demo / Screenshots
- I found app assets and icons under `images/` and platform app icons.
- **No runtime screenshots** (screens captured while the app is running) were included in the repo.
  To produce screenshots for the submission:
  1. Run the app on an emulator/device (`flutter run`).
  2. Navigate through key flows: Sign up → Login → Search → Add to cart → Checkout → Upload prescription → Place order → Order tracking → Profile → Admin.
  3. Take screenshots and save them into `submission_screenshots/` named like `01_login.png`, `02_home.png`, etc.
  4. Add these images to this submission package.

## 7) Suggested screenshot checklist (take these)
- App launcher / home screen
- SignUp screen (with filled sample data)
- Login success / Profile
- Product listing & search results
- Product details (if any)
- Cart with items
- Checkout screen with order summary
- Prescription upload screen (show file chosen)
- Order placed confirmation and OrderTrack screen
- Admin page (if accessible)

## 8) Testing / Acceptance checklist
- [ ] Sign up with a new email — user entry created in Firebase Auth.
- [ ] Login with registered user.
- [ ] Upload a prescription image — file appears in Firebase Storage.
- [ ] Add items to cart and complete checkout — order appears in Firestore.
- [ ] View order tracking status.
- [ ] Admin actions (create/update products or orders) function as expected.

## 9) Files included in this submission package
- Full project (original)
- This file: `README_submission.md`
- `submission_screenshots/` (empty — please add runtime screenshots)
- `file_list.txt` (flat list of repo files)

---
## 10) Troubleshooting tips
- If `firebase_core` initialization fails, ensure `google-services.json` matches Firebase project and `package_name` in `AndroidManifest.xml`.
- For iOS run `pod install` in `ios/` and open in Xcode to check signing.
- If dependencies mismatch, run `flutter clean` then `flutter pub get`.

If you want, I can:
- (A) Generate a PDF of this submission document and bundle it into a zip ready for upload.
- (B) Try to start the app in an emulator here and capture screenshots **if you provide confirmation** to run the Flutter app in this environment (note: the current environment may not have an emulator).
- (C) Populate `submission_screenshots/` with mock placeholder images.

Tell me which of (A), (B), or (C) you want me to do now; I've already prepared the submission folder and files.
