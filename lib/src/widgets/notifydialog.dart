import 'package:flutter/material.dart';

notifyDialog(String? titleText, Widget text, BuildContext context) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(titleText ?? 'Huomio'), //Text(AppLocalizations?.of(context)!=null ? AppLocalizations.of(context)!.notification),
        content: SingleChildScrollView(child: text),
        actions: <Widget>[
          ElevatedButton(
              child: const Text('Ok'), //Text(AppLocalizations.of(context)!.ok),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              })
        ],
      ));
}