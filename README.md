

# 

# RetCore
<p>RetCore is a Flutter package that provides essential components designed to simplify coding for beginners. With user-friendly utilities and tools, RetCore helps new developers write cleaner, more efficient code with ease. Perfect for those just starting their coding journey, RetCore provides the building blocks needed to develop robust applications.</p>

### Installing:

```
dependencies:
   retcore:
        git:
          url: https://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@github.com/samiulhaquereal/RetCore.git
  

```
### Import

```
import 'package:retcore/retcore.dart';

```



### Features

* RetCoreButton
* RetCoreActivityDetector
* RetCoreCarousel
* RetCoreChipInputField 
* RetCoreCircularProgressBar
* RetCoreDropdownField
* RetCoreFadeAnimation
* RetCoreFlipAnimation
* RetCoreGlassmorphism
* RetCoreLinearProgressBar
* RetCoreNeumorphism
* RetCoreOTPFieid
* RetCoreParallaxCarousel
* RetCoreTextField 
* RetCoreApiClient

#### Some important functions

* <p>space</p>

* <p>getDeviceInfo</p>

* <p>width</p>

* <p>height</p>

* <p>bottomDialogBox</p>

* <p>convertIntoBanglaDigit</p>

* <p>dialogBox</p>

* <p>fileDownload</p>

* <p>getDateBangla </p>

* <p>getDateEnglish</p>

* <p>getDayBangla</p>

* <p>getDayEnglish</p>

* <p>getDayNameBangla</p>

* <p>getDayNameEnglish</p>

* <p>getMonthNameBangla </p>

* <p>getMonthNameEnglish </p>

* <p>getMonthNumberBangla</p>

* <p>getMonthNumberEngIish</p>

* <p>getTimeBangla </p>

* <p>getYearBangla </p>

* <p>getYearEnglish</p>

* <p>getOS </p>

* <p>getRootDeviceStatus </p>

* <p>infinity </p>

* <p>isDesktop </p>

* <p>isMobile </p>

* <p>isTablet</p>

* <p>now</p>

* <p>parseBool </p>

* <p>parseColor </p>

* <p>parseDateTime</p>

* <p>parseInt</p>

* <p>parseDouble </p>

* <p>parseInputType</p>

* <p>parseKeyboardType</p>

* <p>parseList </p>

* <p>parseString</p>

* <p>removeNullValues </p>

* <p>snackbar </p>

* <p>back( Widget Page )</p>

* <p>to(Widget page)</p>

* <p>bottomsheet </p>

* <p>debounce </p>

* <p>getData</p>

* <p>setData</p>

* <p>removeData </p>

* <p>showSnackbar</p>

* <p>startAutoSession </p>

* <p>startTouchDetection</p>

* <p>stopTouchDetectionAndAutoSession</p>

### RetCoreTextfield

#### Key Features


* Easily design any kind of TextField
* Easily choose DatePicker from one text field by changing one parameter.
* By changing one parameter TextField can be convert into password field with obscureText.
* Easily check validation.

#### How to use
<p>All kind of design use in one textField.</p>

```
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  label: 'Name Field',
  labelColor: Colors.grey,
  labelSize: 18,
  inputFontSize: 22,
  isPrefixIcon: true,
  icon: CupertinoIcons.person,
  focusedColor: Colors.red,
)

```
<p>DatePicker field</p>

```
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  isDatePicker: true,
)

```
<p>Password field</p>

```
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  label: 'Password',
  isPasswordField: true,
)

```
<p>Validate the TextField</p>

```
RetCoreTextField(
  controller: TextEditingController(),
  isBorder: true,
  label: 'Password',
  isPasswordField: true,
  isRequired: true,
  validator: (){},
)

```

### Changelog
<p>CHANGELOG</p>
