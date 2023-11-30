
import 'package:fiteens/src/util/styles.dart';
import 'package:flutter/material.dart';

export 'popupdialog.dart';
export 'handlenotifications.dart';
export 'notifydialog.dart';
export 'bottomnavigation.dart';

MaterialButton longButtons(String title, Function()? fun,
    {Color? color, Color textColor = Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color ?? buttonColorPrimary,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
  );
}

label(String title,{TextStyle? style}) => Text(title,style: style,);

InputDecoration buildInputDecoration(String hintText, IconData? icon,{Widget? suffixIcon,String? labelText}) {

  return InputDecoration(
    prefixIcon: Icon(icon),
    hintText: hintText,
    labelText: labelText,
    suffixIcon: suffixIcon,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

