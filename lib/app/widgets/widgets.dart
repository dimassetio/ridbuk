import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
        color: color ?? Colors.white,
      ),
      child: Column(
        crossAxisAlignment: crossAxis ?? CrossAxisAlignment.start,
        mainAxisAlignment: mainAxis ?? MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
