
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
    height: 45,
    minWidth: 600,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

label(String title,{TextStyle? style}) => Text(title,style: style,);

InputDecoration buildInputDecoration(String hintText, IconData? icon,{Widget? suffixIcon,String? labelText}) {

  return InputDecoration(
    prefixIcon: Icon(icon),
    hintText: hintText,
    labelText: labelText,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}

