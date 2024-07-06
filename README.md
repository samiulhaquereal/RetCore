

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