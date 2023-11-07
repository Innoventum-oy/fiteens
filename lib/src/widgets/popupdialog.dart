import 'package:flutter/material.dart';


popupDialog(String? titleText, Widget dialogContent, BuildContext context,
    {List<Widget>? actions}) async {

  return await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titleText != null
            ? titleText
            : 'Huomio'), //Text(AppLocalizations?.of(context)!=null ? AppLocalizations.of(context)!.notification),
        content: dialogContent,
        actions: actions ??
            <Widget>[
              ElevatedButton(
                  child:
                  Text('Ok'), //Text(AppLocalizations.of(context)!.ok),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  })
            ],
      ));
}