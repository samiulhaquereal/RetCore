# RetCore

**RetCore** is a Flutter package that provides essential components designed to simplify coding for beginners. With user-friendly utilities and tools, RetCore helps new developers write cleaner, more efficient code with ease. Perfect for those just starting their coding journey, RetCore provides the building blocks needed to develop robust applications.

---

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
retcore:
  git:
    url: https://github.com/samiulhaquereal/RetCore.git
```

---

## 📦 Import

```dart
import 'package:retcore/retcore.dart';
```

---

## ✨ Features

### Widgets
- `RetCoreButton`
- `RetCoreActivityDetector`
- `RetCoreCarousel`
- `RetCoreChipInputField`
- `RetCoreCircularProgressBar`
- `RetCoreDropdownField`
- `RetCoreFadeAnimation`
- `RetCoreFlipAnimation`
- `RetCoreGlassmorphism`
- `RetCoreLinearProgressBar`
- `RetCoreNeumorphism`
- `RetCoreOTPField`
- `RetCoreParallaxCarousel`
- `RetCoreTextField`
- `RetCoreApiClient`

### Utilities

Use with `RetCore.` prefix, for example: `RetCore.space(10);`

#### 📐 Layout & Device
- `space(double value)`
- `width()`, `height()`
- `getDeviceInfo()`
- `getOS()`
- `isMobile()`, `isTablet()`, `isDesktop()`

#### 📅 Date & Time
- `getDateBangla()`, `getDateEnglish()`
- `getDayBangla()`, `getDayEnglish()`
- `getDayNameBangla()`, `getDayNameEnglish()`
- `getMonthNameBangla()`, `getMonthNameEnglish()`
- `getMonthNumberBangla()`, `getMonthNumberEnglish()`
- `getTimeBangla()`, `getYearBangla()`, `getYearEnglish()`

#### 🧠 Converters & Tools
- `convertIntoBanglaDigit(String number)`
- `parseBool()`, `parseInt()`, `parseDouble()`
- `parseColor()`, `parseDateTime()`, `parseString()`
- `parseList()`, `parseInputType()`, `parseKeyboardType()`
- `removeNullValues(Map)`
- `formatNumber(num)`
- `emptyFieldCheck(List<TextEditingController>)`

#### 📦 Data Storage
- `getData(String key)`
- `setData(String key, dynamic value)`
- `removeData(String key)`

#### 🧾 Navigation & UI
- `to(Widget page)`, `back(Widget page)`
- `dialogBox()`, `bottomDialogBox()`, `bottomsheet()`
- `snackbar()`, `showSnackbar()`

#### ⚡ System
- `fileDownload(String url)`
- `debounce(String key, Function)`
- `getRootDeviceStatus()`

#### 🔐 Auto Session & Touch
- `startAutoSession()`
- `startTouchDetection()`
- `stopTouchDetectionAndAutoSession()`

---

## 🧾 RetCoreTextField

### 🔑 Key Features
- Easily design custom text fields.
- One toggle to enable date picker.
- One toggle to enable password input.
- Built-in validation support.

### 💡 Examples

#### Basic TextField

```dart
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  label: 'Name',
  labelColor: Colors.grey,
  labelSize: 18,
  inputFontSize: 22,
  isPrefixIcon: true,
  icon: CupertinoIcons.person,
  focusedColor: Colors.red,
)
```

#### Date Picker Field

```dart
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  isDatePicker: true,
)
```

#### Password Field

```dart
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  label: 'Password',
  isPasswordField: true,
)
```

#### Validation

```dart
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  label: 'Password',
  isPasswordField: true,
  isRequired: true,
  validator: () {
    // Custom validation logic
  },
)
```

---

## 📜 Changelog
CHANGELOG

---
