import 'package:retcore/src/config/imports.dart';

class ChipInputField extends StatefulWidget {
  ChipInputField({
    super.key,
    this.title,
    this.hint,
    this.keyboardType,
    this.isRequired,
    required this.chipsList,
    this.isEnable,
    this.onDeleted,
    this.onFieldSubmitted,
  });

  final String? title;
  final String? hint;
  final RetCoreKeyboardType? keyboardType;
  final bool? isRequired;
  final List<dynamic> chipsList;
  bool? isEnable = false;
  final void Function(String)? onDeleted;
  final void Function(String)? onFieldSubmitted;

  @override
  _ChipInputFieldState createState() => _ChipInputFieldState();
}

class _ChipInputFieldState extends State<ChipInputField> {
  final TextEditingController inputHsCode = TextEditingController();
  bool isValid = true;

  @override
  Widget build(BuildContext context) {

    return InputDecorator(
      decoration: InputDecoration(
        enabled: widget.isEnable ?? true,
        hintText: widget.hint,
        isDense: true,
        errorText: isValid == false ? '*Required' : null,
        label: widget.title== null ? null : RichText(
          text: TextSpan(
            text: '${widget.title}',
            style: TextStyle(fontSize: 7, color: tBlack),
            children: [
              TextSpan(
                text: widget.isRequired == true ? '*' : '',
                style: TextStyle(fontSize: 10,color: tRed),
              ),
            ],
          ),
        ),
        labelStyle: TextStyle(fontSize: 7, color: tBlack),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tBlack),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tRed),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tRed),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: tBlack),
          borderRadius: BorderRadius.circular(5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.chipsList.map((chip) {
                return SizedBox(
                  height: 30,
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: tBlack), // Set border color to red
                      borderRadius: BorderRadius.circular(5),
                    ),
                    deleteIconColor: tRed,
                    padding: EdgeInsets.zero,
                    label: Text(chip),
                    labelStyle: TextStyle(fontSize: 10),
                    onDeleted: () {
                      setState(() {
                        widget.chipsList.remove(chip);
                        if (widget.onDeleted != null) {
                          widget.onDeleted!(chip);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            RetCore.space(7),
            SizedBox(
              width: RetCore.width(),
              child: TextFormField(
                keyboardType: RetCore.parseKeyboardType(type: widget.keyboardType),
                controller: inputHsCode,
                style: TextStyle(fontSize: 10),
                enabled: widget.isEnable ?? true,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                onChanged: (_){
                  isValid = true;
                },
                onFieldSubmitted: (value) {
                  _addChip(value);
                  if (widget.onFieldSubmitted != null) {
                    widget.onFieldSubmitted!(value);
                  }
                },
                validator: (value) {
                  if (value!.isEmpty && widget.chipsList.isEmpty && widget.isRequired == true) {
                    isValid = false;
                    return '';
                  }else{
                    isValid = true;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addChip(String chip) {
    if (chip.isNotEmpty && !widget.chipsList.contains(chip)) {
      setState(() {
        widget.chipsList.add(chip);
        inputHsCode.clear();
      });
    }
  }
}