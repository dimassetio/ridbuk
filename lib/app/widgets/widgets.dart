import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:ridbuk/app/const/color.dart';

Widget text(
  String? text, {
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  bool isLongText = false,
}) =>
    Text(
      text ?? '',
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: isLongText ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
inputText(
    {TextFieldType textFieldType = TextFieldType.NAME,
    TextEditingController? controller,
    bool? isValidationRequired,
    bool? isEnabled,
    bool? isReadOnly,
    Icon? icon,
    String? label,
    String? initValue,
    String? hint,
    Color? suffixColor,
    String? Function(String?)? validator}) {
  return AppTextField(
    controller: controller,
    isValidationRequired: isValidationRequired,
    textFieldType: textFieldType,
    decoration: InputDecoration(
      prefixIcon: icon,
      labelText: label,
      hintText: hint,
      suffixIconColor: suffixColor,
    ),
    enabled: isEnabled,
    readOnly: isReadOnly,
    validator: validator,
    initialValue: initValue,
  );
}

class InputText extends StatelessWidget {
  InputText({
    this.textFieldType = TextFieldType.NAME,
    this.controller,
    this.isValidationRequired,
    this.isEnabled,
    this.isReadOnly,
    this.icon,
    this.label,
    this.initValue,
    this.hint,
    this.suffixColor,
    this.validator,
  });

  TextFieldType textFieldType = TextFieldType.NAME;
  TextEditingController? controller;
  bool? isValidationRequired;
  bool? isEnabled;
  bool? isReadOnly;
  Icon? icon;
  String? label;
  String? initValue;
  String? hint;
  Color? suffixColor;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      isValidationRequired: isValidationRequired,
      textFieldType: textFieldType,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: label,
        hintText: hint,
        suffixIconColor: suffixColor,
      ),
      enabled: isEnabled,
      readOnly: isReadOnly,
      validator: validator,
      initialValue: initValue,
    );
  }
}

class BoxContainer extends StatelessWidget {
  BoxContainer(
      {this.children = const [],
      this.padding = 16,
      this.height,
      this.width,
      this.radius,
      this.color,
      this.crossAxis,
      this.mainAxis});
  List<Widget> children;
  double padding;
  double? height;
  double? width;
  double? radius;
  Color? color;
  MainAxisAlignment? mainAxis;
  CrossAxisAlignment? crossAxis;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: boxDecorationDefault(
        borderRadius: BorderRadius.circular(radius ?? 16),
        boxShadow: defaultBoxShadow(),
        color: color ?? clr_white,
      ),
      child: Column(
        crossAxisAlignment: crossAxis ?? CrossAxisAlignment.start,
        mainAxisAlignment: mainAxis ?? MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
