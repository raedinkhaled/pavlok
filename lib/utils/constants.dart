import 'package:flutter/cupertino.dart';

const DEFAULT_UTILITY_RADIUS = 20.0;

Widget nbAppTextFieldWidget(TextEditingController controller, String hintText, TextFieldType textFieldType, {FocusNode? focus, FocusNode? nextFocus}) {
  return AppTextField(
    controller: controller,
    textFieldType: textFieldType,
    textStyle: primaryTextStyle(size: 14),
    focus: focus,
    nextFocus: nextFocus,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      filled: true,
      fillColor: grey.withOpacity(0.1),
      hintText: hintText,
      hintStyle: secondaryTextStyle(),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    ),
  );
}
